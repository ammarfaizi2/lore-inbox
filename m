Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274037AbRIXQzS>; Mon, 24 Sep 2001 12:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274031AbRIXQx7>; Mon, 24 Sep 2001 12:53:59 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:49415 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S274035AbRIXQxt>; Mon, 24 Sep 2001 12:53:49 -0400
Date: Mon, 24 Sep 2001 18:54:13 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010924185413.C10117@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
In-Reply-To: <20010924174745.A8230@emma1.emma.line.org> <E15lYHC-0002zc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E15lYHC-0002zc-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, Alan Cox wrote:

> > Those drives should be blacklisted and rejected as soon as someone tries
> > to mount those pieces rw. Either the drive can make guarantees when a
> > write to permanent storage has COMPLETED (either by switching off the
> > cache or by a flush operation) or it belongs ripped out of the boxes and
> > stuffed down the throat of the idiot who built it.
> 
> In which case you can choose between ancient ST-506 drives and SCSI

Sorry, a disk drive which makes no guarantees even after a flush, does
not belong in my boxen. I'd return it as broken the first day I figured
it did lazy write-back caching. No file system can be safe on such
disks.

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
