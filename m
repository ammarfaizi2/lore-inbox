Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285593AbSAMPIM>; Sun, 13 Jan 2002 10:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285134AbSAMPID>; Sun, 13 Jan 2002 10:08:03 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:51351 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S284979AbSAMPHy>; Sun, 13 Jan 2002 10:07:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ugly warnings with likely/unlikely
Date: Sun, 13 Jan 2002 16:06:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16PmEA-0007Ai-00@the-village.bc.nu>
In-Reply-To: <E16PmEA-0007Ai-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16PmEJ-1Pq1bsC@fwd04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 January 2002 16:07, Alan Cox wrote:
> > if (likely(stru->pointer))
> >
> > results in an ugly warning about using pointer as int.
> > Is there something that could be done against that ?
>
> 	if (likely(stru->pointer == NULL))
>
> Perhaps ?

That works. But it's so much work to type it.

	Regards
		Oliver

