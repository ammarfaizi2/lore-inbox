Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJUs5>; Wed, 10 Jan 2001 15:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130018AbRAJUsj>; Wed, 10 Jan 2001 15:48:39 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:56332 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S129406AbRAJUsX>;
	Wed, 10 Jan 2001 15:48:23 -0500
Date: Wed, 10 Jan 2001 22:48:17 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: Nathan Walp <faceprint@faceprint.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.4.0-ac5
In-Reply-To: <3A5CC4B2.74B911BD@faceprint.com>
Message-ID: <Pine.LNX.4.30.0101102243010.30013-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Nathan Walp wrote:
> Here it is... I opted to cut out the 1200-odd warnings, which from the
> look of them were all because i'm running it under 2.4.0-ac4 (which
> boots fine).

Thanks! My local mirror does not have -ac5 yet so I can't help
immediately. From the -ac5 log & the oops it looks as if Ingo's change
isn't quite complete yet...

  o       Uniprocessor APIC support/NMI wdog etc          (Ingo Molnar)

Until then, what about disabling APIC support and trying again. This
will help confirm it... although it looks pretty definite.

-- Hans


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
