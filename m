Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276720AbRJBVz2>; Tue, 2 Oct 2001 17:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276721AbRJBVzT>; Tue, 2 Oct 2001 17:55:19 -0400
Received: from [205.176.221.61] ([205.176.221.61]:60174 "EHLO w20303512")
	by vger.kernel.org with ESMTP id <S276720AbRJBVzL>;
	Tue, 2 Oct 2001 17:55:11 -0400
Message-ID: <045c01c14b8d$120b31c0$3dddb0cd@w20303512>
From: "Wilson" <defiler@null.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <200110021941.VAA13062@harpo.it.uu.se>
Subject: Re: Strange CD-writing problem
Date: Tue, 2 Oct 2001 17:56:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Mikael Pettersson" <mikpe@csd.uu.se>
To: <lior@netvision.net.il>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, October 02, 2001 3:41 PM
Subject: Re: Strange CD-writing problem


> On Tue, 2 Oct 2001 19:41:53 +0200 (IST), Lior Okman wrote:
>
> >I recently bought a new IDE cd-rw (a Plextor W1610A).
> >While trying to burn with it, I had some trouble fixating the disks.
>
> I'd move that ATAPI cd-rw to the primary controller, and reserve
> the Promise controller for UDMA(33) and above disks.

Just thought I'd add something here: Even Promise suggests that you not run
optical drives on their controllers. They aren't trustworthy when connected
to Ultra100 controllers even under Win98/Win2k. I don't have an exact quote
for you, but this has been discussed (with feedback from Promise) on
StorageReview.

Regards,
--Wilson.


