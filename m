Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267588AbTA3SqI>; Thu, 30 Jan 2003 13:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbTA3SqI>; Thu, 30 Jan 2003 13:46:08 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57033 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267588AbTA3SqH>; Thu, 30 Jan 2003 13:46:07 -0500
Date: Thu, 30 Jan 2003 13:55:28 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Konrad Eisele <eiselekd@web.de>
Cc: PeteZaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: perl (Was: Adding sparc-leon linux to sourcetree)
Message-ID: <20030130135528.C12226@devserv.devel.redhat.com>
References: <200301301353.h0UDrxO24129@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301301353.h0UDrxO24129@mailgate5.cinetic.de>; from eiselekd@web.de on Thu, Jan 30, 2003 at 02:53:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 30 Jan 2003 14:53:59 +0100
> From: Konrad Eisele <eiselekd@web.de>

> There is also one change I have made on the buildsystem. Because
> I'm using some perl inline scripts in the $cmd_xxx the >'<  and >$<
> signs in the inline perl scripts cause trouble (perl -e '...$x=....'),
> the >'< because of the echo command, the >$< when rereading from
> the xxx..cmd files. Could this be applied to the original file?

First, send a patch, not a chunk of a Makefile.

Second, this is something I defer to Kai, Sam, & Co.

Personally, I am opposed to a use of perl, because it's not
installed in my sparc userland, so I would not be able to
self-compile a leon or joint kernel. But ultimately this is
not my call to decide. At one point, Linus approved Python
into the toolchain. So, present good evidence of need and post
to lists.

-- Pete
