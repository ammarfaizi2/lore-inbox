Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314280AbSD0Qap>; Sat, 27 Apr 2002 12:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314282AbSD0Qao>; Sat, 27 Apr 2002 12:30:44 -0400
Received: from hera.cwi.nl ([192.16.191.8]:19594 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314280AbSD0Qan>;
	Sat, 27 Apr 2002 12:30:43 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 27 Apr 2002 18:30:42 +0200 (MEST)
Message-Id: <UTC200204271630.g3RGUgF04840.aeb@smtp.cwi.nl>
To: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.x-dj and SCSI error handling.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The recent patch from Christoph Hellwig which kills off
> the last remaining remnants of the old style SCSI error handling.
> ...

Is the new scsi-eh generally regarded as a good thing?

(Personally I have only bad experiences with it.
Usually commented it out, otherwise its error handling
would kill my box as soon as a SCSI error occurred.
I vastly prefer an error return "I/O error"
above a long series (several minutes) of retries,
device resets, bus resets making the machine entirely
unusable during this time, and often causing an oops
in the end, killing off the machine entirely.
However, I have no recent experiences here.)

Andries


