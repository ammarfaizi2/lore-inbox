Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271332AbRHTQiN>; Mon, 20 Aug 2001 12:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271376AbRHTQiD>; Mon, 20 Aug 2001 12:38:03 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:55073 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271332AbRHTQht>; Mon, 20 Aug 2001 12:37:49 -0400
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
From: Robert Love <rml@tech9.net>
To: Johan Adolfsson <johan.adolfsson@axis.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br
In-Reply-To: <21a701c12963$bcb05b60$0a070d0a@axis.se>
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org>
	<998193404.653.12.camel@phantasy> <3B80E01B.2C61FF8@evision-ventures.com> 
	<21a701c12963$bcb05b60$0a070d0a@axis.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.19.07.08 (Preview Release)
Date: 20 Aug 2001 12:36:52 -0400
Message-Id: <998325471.2936.25.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Aug 2001 12:34:48 +0200, Johan Adolfsson wrote:
> And I think you are wrong, this patch is needed.
> Keep up the good work Robert!

I will -- thank you for the words. :)

> Where would you get the single seed from in an embedded head
> less system if you don't have a hardware random generator,
> no disk and don't seed it from the network interrupts?

exactly.  this thread has gone off on a tangent arguing the very merits
of /dev/random itself.  obviously if you dislike the kernel's entropy
gatherer, this patch won't sit well either.

the proper argument is, assuming that /dev/random is A Good Thing, is
this patch useful?  since its configurable, its not forcing any policy.
since it can be argued pretty strongly that more entropy is needed on a
headless and/or diskless, I think some people need it.  personally, it
boosts my self-esteem to have another source of entropy (my 3c905).  if
you are worried of the threats net devices have to your entropy, by all
means -- dont enable the config setting.

> I think the patch makes sense - let people have the config option.

hopefully we can get the patch merged, if for nothing else for 2.5.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

