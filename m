Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289089AbSA1Brh>; Sun, 27 Jan 2002 20:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289090AbSA1Br3>; Sun, 27 Jan 2002 20:47:29 -0500
Received: from msg.vizzavi.pt ([212.18.167.162]:25640 "EHLO msg.vizzavi.pt")
	by vger.kernel.org with ESMTP id <S289089AbSA1BrK>;
	Sun, 27 Jan 2002 20:47:10 -0500
Date: Mon, 28 Jan 2002 01:54:31 +0000
From: "Paulo Andre'" <l16083@alunos.uevora.pt>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: Can't compile Symbios 53c416 SCSI support
Message-ID: <20020128015431.A27512@bleach>
In-Reply-To: <20020127201213.A7091@bleach> <20020128043833.659e7102.johnpol@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020128043833.659e7102.johnpol@2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Mon, Jan 28, 2002 at 01:38:33 +0000
X-Mailer: Balsa 1.3.0
X-OriginalArrivalTime: 28 Jan 2002 01:47:04.0257 (UTC) FILETIME=[AFB39310:01C1A79D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002.01.28 01:38 Evgeniy Polyakov wrote:
> It seems that io_request_lock will be completely removed in 2.5 tree,
> so
> there is no io_request_lock in linux/blk.h. This global lock now
> exsist
> only in scsi layer, and it will be replaced by Scsi_Host->host_lock
> soon.
> So i hope this patch will help a bit in this direction.
> 
> 2 Paulo Andre: DON'T use this patch before Jens Axboe will agree with
> it,
> because i even haven't scsi here, so this patch was written only with
> common sence. I hope this will help you.

I see your point. I was also thinking about something along those 
lines. Anyway, what patch are you talking about? Perhaps you forgot to 
paste/attach it to your email?

And perhaps Jens could also give me a word about this?

Cheers Evgeniy and thanks again,

// Paulo Andre'
