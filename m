Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272181AbRIJXfx>; Mon, 10 Sep 2001 19:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272164AbRIJXfo>; Mon, 10 Sep 2001 19:35:44 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:20473 "HELO
	devbox.kroptech.com") by vger.kernel.org with SMTP
	id <S272181AbRIJXfa>; Mon, 10 Sep 2001 19:35:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Adam Kropelin <akropel1@rochester.rr.com>
Reply-To: akropel1@rochester.rr.com
Organization: KropTech
To: hugh@veritas.com
Subject: Re: scsi_io_completion oops on 2.4.10-pre5
Date: Mon, 10 Sep 2001 19:35:49 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01091019354900.05688@devbox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickens wrote:
> On Sun, 9 Sep 2001, Adam Kropelin wrote:
> > The below oops is easily reproducable for me under 2.4.10-pre5.
> > Unable to handle kernel paging request at virtual address 46454c22
> > >>EIP; c020c444 <scsi_io_completion+88/370>   <=====
>
> Although there's nothing about this to link it with the page_alloc.c
> BUGs, that's clearly corruption ("LEF), and the page_alloc.c BUGs
> were caused by double use of a page: I wouldn't trust 2.4.10-pre5,
> think you should try to reproduce on -pre6 or -pre7 instead.

Sound advice, indeed. 2.4.10-pre7 handles everything I can throw
at it. I guess I just picked a bad Linus kernel to start with...

Thanks for the pointer.

--Adam
