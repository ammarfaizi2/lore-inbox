Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbQKSQxn>; Sun, 19 Nov 2000 11:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132593AbQKSQxe>; Sun, 19 Nov 2000 11:53:34 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:11560 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S132556AbQKSQxY>; Sun, 19 Nov 2000 11:53:24 -0500
Message-ID: <3A17FE13.9DE68202@linux.com>
Date: Sun, 19 Nov 2000 08:21:39 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christer Weinigel <wingel@hog.ctrl-c.liu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <20001119150837.8EF2737237@hog.ctrl-c.liu.se>
Content-Type: multipart/mixed;
 boundary="------------4DB9A59F8148DAF0006CCCB0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4DB9A59F8148DAF0006CCCB0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Christer Weinigel wrote:

> >Kernel on writeprotected floppy disk...
>
> So change the CMOS-settings so that the BIOS changes the boot order
> from A, C, CD-ROM to C first instead.  *grin*  How long do you want
> to keep playing Tic-Tac-Toe?
>
> Of course, using capabilities and totally disabling access to the raw
> disk devices and to any I/O ports might be the solution, provided that
> there are no bugs or thinkos in the capabilities code.

How much time do you want to spend hardening your system?  A few simple steps can
make things very hard for a remote attacker.

Everyone wants to decry every tiny little step saying there are a dozen ways to
get around it.  But take 12 simple steps to take care of those dozen ways, and
you've upped the bar sufficiently.  It will take a much more skilled person to
get past your defenses.

Most exploits depend on a common system layout.  I.e. a redhat script issue.
Immediately you have hundreds of thousands of systems around the world which are
probably vulnerable.  If however you've only installed 10 megs worth of total
system programs and kernel etc that you've carefully decided are necessary, you
probably don't have those scripts.  With this attention to detail, you probably
shut off all those extraneous services like rpc.statd.  Chances are you have a
chrooted BIND and on top of that you're running 9.0.1rc2.  With all that covered
I'd hazard a guess that your nicely tidied up iptables are preventing access to
anything you're not paying attention to.

Every item you add to this hardening checklist makes your system much less of a
target.  First it has less of a signature on a perp's someisp.addresses.com
sweep, and second, once it's found there are less and less available options for
intrusion.

So instead of doing nothing because someone can always infiltrate your system, do
a few somethings so it raises the bar against whomever tries.

Those dozen doors are great for a shopping mall, but bad for a classified room.

-d


--------------4DB9A59F8148DAF0006CCCB0
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------4DB9A59F8148DAF0006CCCB0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
