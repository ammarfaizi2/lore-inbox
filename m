Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSHHIAn>; Thu, 8 Aug 2002 04:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSHHIAn>; Thu, 8 Aug 2002 04:00:43 -0400
Received: from [195.63.194.11] ([195.63.194.11]:23050 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316684AbSHHIAn>; Thu, 8 Aug 2002 04:00:43 -0400
Message-ID: <3D5224B7.9080604@evision.ag>
Date: Thu, 08 Aug 2002 09:58:47 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       jmacd@namesys.com, phillips@arcor.de, rml@tech9.net
Subject: Re: [PATCH] lock assertion macros for 2.5.30
References: <20020807210855.GA27182@sgi.com> <Pine.LNX.4.44L.0208071814250.23404-100000@imladris.surriel.com> <20020807213949.GA27258@sgi.com>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jesse Barnes napisa?:
> On Wed, Aug 07, 2002 at 06:21:07PM -0300, Rik van Riel wrote:
> 
>>On Wed, 7 Aug 2002, Jesse Barnes wrote:
>>
>>>macro worked before?  I could just remove all those checks in the scsi
>>>code I guess.
>>
>>That would be a better option.
> 
> 
> Ok.
> 
> 
>>The MUST_NOT_HOLD basically means the kernel will OOPS the
>>moment the lock is contended.

And for Gods sake ;-) - please call it ASSERT_ and not MUST_THIS
MUST_THAT MUST_GO_TO_TOILET. For the nonanglosaxons among us the
personifications already  frequently enough present in english
nomenclature sound already awfoul enough... Additionally gerp -i assert
will work as expected, since MUST is a far more frequent term.

