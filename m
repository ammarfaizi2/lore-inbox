Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278387AbRJSNIB>; Fri, 19 Oct 2001 09:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278388AbRJSNHv>; Fri, 19 Oct 2001 09:07:51 -0400
Received: from ns.suse.de ([213.95.15.193]:6925 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278387AbRJSNHq> convert rfc822-to-8bit;
	Fri, 19 Oct 2001 09:07:46 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
        Arjan Van de Ven <arjanv@redhat.com>
Subject: Re: [patch] block highmem zero-bounce #17
In-Reply-To: <20011018144047.E4825@suse.de>
X-Yow: Let's all show human CONCERN for REVEREND MOON's legal difficulties!!
From: Andreas Schwab <schwab@suse.de>
Date: 19 Oct 2001 15:08:12 +0200
In-Reply-To: <20011018144047.E4825@suse.de> (Jens Axboe's message of "Thu, 18 Oct 2001 14:40:47 +0200")
Message-ID: <jen12n4w1v.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.107
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

|> Patch is considered solid. Find it here:
|> 
|> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.13-pre4/block-highmem-all-17.bz2

Your patch still makes bad use of struct scatterlist which is architecture
dependent.  Either fix the definitions in asm-*/scatterlist.h or go back
using a private struct.  Why did you switch to struct scatterlist in the
first place??

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
