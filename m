Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264475AbTCXWRd>; Mon, 24 Mar 2003 17:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264477AbTCXWRd>; Mon, 24 Mar 2003 17:17:33 -0500
Received: from port-212-202-173-211.reverse.qdsl-home.de ([212.202.173.211]:27015
	"EHLO jackson.localnet") by vger.kernel.org with ESMTP
	id <S264475AbTCXWRb> convert rfc822-to-8bit; Mon, 24 Mar 2003 17:17:31 -0500
Date: Mon, 24 Mar 2003 23:31:05 +0100 (CET)
Message-Id: <20030324.233105.719910094.rene.rebe@gmx.net>
To: pavel@suse.cz
Cc: ncunningham@clear.net.nz, linux-kernel@vger.kernel.org,
       swsusp@lister.fornax.hu, rock-linux@rocklinux.org
Subject: Re: Testers wanted: Software Suspend for 2.4
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <20030325091406.GC1083@zaurus.ucw.cz>
References: <1048023854.2163.16.camel@laptop-linux.cunninghams>
	<20030320.233918.730551503.rene.rebe@gmx.net>
	<20030325091406.GC1083@zaurus.ucw.cz>
X-Mailer: Mew version 3.1 on XEmacs 21.4.12 (Portable Code)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

root= "seems" to be devfs aware. It always simply worked.

I read the source when I have time (which might be in some days).

On: Tue, 25 Mar 2003 10:14:06 +0100,
    Pavel Machek <pavel@suse.cz> wrote:
> Hi!
> 
> > Thanks for your work!
> > 
> > I just manged to suspend and resume a freshly booted 2.4.20 + "your
> > latest patch" system ;-)
> > 
> > I had to read the kernel source a hour to do so, because I use devfs
> > and naively used resume=/dev/ide/host0/.... which obiously does not
> > work.
> > 
> > For now you might add to the docs that devfs users simply have to use
> > the corresponding old /dev/hdX name. If I have too much time I'll take
> > a look to make swsuspend devfs aware. But this might not be that soon
> > :-(
> 
> Is root= devfs aware? If yes fix swsusp
> else fix docs.
> 				Pavel

- René

--  
René Rebe - Europe/Germany/Berlin
e-mail:   rene@rocklinux.org, rene.rebe@gmx.net
web:      http://www.rocklinux.org/people/rene http://gsmp.tfh-berlin.de/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
