Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbSBJWYT>; Sun, 10 Feb 2002 17:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbSBJWX7>; Sun, 10 Feb 2002 17:23:59 -0500
Received: from ip68-4-123-226.oc.oc.cox.net ([68.4.123.226]:52212 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S284300AbSBJWX6>; Sun, 10 Feb 2002 17:23:58 -0500
Subject: Re: [RAID-soft,ATA,WD] problems with a RAID5 disc not detected
To: cyrille@chepelov.org (Cyrille Chepelov)
Date: Sun, 10 Feb 2002 14:24:09 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, neilb@cse.unsw.edu.au,
        andre@linux-ide.org, jmontpezat@nerim.net
In-Reply-To: <20020210205653.GA20212@calixo.net> from "Cyrille Chepelov" at Feb 10, 2002 09:56:53 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020210222409.B11EC8974E@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cyrille Chepelov wrote:
> Blam! the BIOS refuses to detect the WD disc, unless it's the only disc on
> its ribbon cable (even with a 80-wire cable). Fortunately, Linux doesn't
> really care, and it was possible to make use of this bad boy.

Note that "Master" and "Single" are generally two different jumper
settings on WD disks; you need to use the "Master" setting when there are
two drives on the cable and the "Single" setting when there's only one...

-Barry K. Nathan <barryn@pobox.com>
