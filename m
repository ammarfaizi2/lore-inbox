Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbTAOSIh>; Wed, 15 Jan 2003 13:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTAOSIh>; Wed, 15 Jan 2003 13:08:37 -0500
Received: from [66.70.28.20] ([66.70.28.20]:22022 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266795AbTAOSIf>; Wed, 15 Jan 2003 13:08:35 -0500
Date: Wed, 15 Jan 2003 19:17:28 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: argv0 revisited...
Message-ID: <20030115181728.GA47@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    Finally, with a suitable solution at hand, I notice that the
kernel does just what I wanted to do, that is, overwriting the
argv[0]. The matter is that when executing the init process, the
kernel substitutes the program name, the true argv0, with the string
'init' :(( That is, I'm not able to exec'ing myself again, because I
no longer know what is the binary name!

    How can I know, more or less portably, which is the name of the
disk binary corresponding to my core image? Since 'proc' is not
mounted at this time, I cannot consult my mappings not my 'exe'
link. Since this init is run as root, any that root can do is
welcome. Although I would like a portable solution, any solution that
works under *any* Linux kernel is welcome...

    BTW, is the argv0 mangling for 'init' mandatory or POSIX or
standard or...?

    Thanks a lot :)

    Raúl
