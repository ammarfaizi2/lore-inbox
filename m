Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285265AbRLNAPo>; Thu, 13 Dec 2001 19:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285274AbRLNAPe>; Thu, 13 Dec 2001 19:15:34 -0500
Received: from mailc.telia.com ([194.22.190.4]:53731 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S285265AbRLNAPX>;
	Thu, 13 Dec 2001 19:15:23 -0500
Message-Id: <200112140015.fBE0FIa04261@mailc.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Jens Axboe <axboe@suse.de>,
        Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual address 00000000 (Was: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c)
Date: Fri, 14 Dec 2001 01:13:01 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de> <20011129175441.N10601@suse.de> <200112132130.fBDLUr511956@mailb.telia.com>
In-Reply-To: <200112132130.fBDLUr511956@mailb.telia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursdayen den 13 December 2001 22.28, Roger Larsson wrote:
> Hmm...
>
> I got the BUG described earlier in this thread with a 2.4.16 kernel
> (sligtly patched but in a different area - update the page structure
> referenced bit when scheduling away a process - it has been running for
> several days)

Following up to myself :--(

There was an additional patch that I had forgotten.
It might cause allocation failures (due to slower movement between lists)
 - but no such thing were indicated in the messages...
And why should it only happen when trying to mount?
(could be the patches again - some kind of version mismatch...)

Now running 2.4.17-rc1 and trying to reproduce it.
I have not succeded yet :-)

/RogerL
-- 
Roger Larsson
Skellefteå
Sweden
