Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319205AbSHUTeK>; Wed, 21 Aug 2002 15:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319117AbSHUTeK>; Wed, 21 Aug 2002 15:34:10 -0400
Received: from tufnell.london1.poggs.net ([193.109.194.18]:23786 "EHLO
	tufnell.london1.poggs.net") by vger.kernel.org with ESMTP
	id <S319205AbSHUTeK>; Wed, 21 Aug 2002 15:34:10 -0400
Date: Wed, 21 Aug 2002 20:38:01 +0100 (BST)
From: Peter Hicks <pwh@poggs.co.uk>
X-X-Sender: pwh@tufnell.london1.poggs.net
Reply-To: peter.hicks@poggs.co.uk
To: alan@lxorguk.ukuu.org.uk
cc: cc@poggs.co.uk, <linux-kernel@vger.kernel.org>
Subject: More on EFS bug
Message-ID: <Pine.LNX.4.44.0208212031530.21363-100000@tufnell.london1.poggs.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan

Here's a little more on the problem.

I've restarted my system, and I could mount the CD fine - modprobe efs, and
the kernel recognises the filesystem without a helping hand.  I noticed I was
using ide-scsi.o for writing last night, so I modprobe'd in scsi_mod,
sr_mod, cdrom and ide-scsi, mounted the CD, and instant problem.

The problem isn't the freshly burnt CD, as I tried with the original SGI CD,
which shows the same problem using ide-scsi, but is fine when I access things
natively over IDE.

Hope the extra detail is of use.

Best wishes,


Peter.

