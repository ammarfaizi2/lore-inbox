Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267579AbRGSO67>; Thu, 19 Jul 2001 10:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267582AbRGSO6t>; Thu, 19 Jul 2001 10:58:49 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:25352 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S267581AbRGSO6n>; Thu, 19 Jul 2001 10:58:43 -0400
From: jdassen@cistron.nl (J.H.M. Dassen (Ray))
Subject: Re: 1GB system working with 64MB
Date: Thu, 19 Jul 2001 14:58:47 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <slrn9ldtd7.fcj.jdassen@odin.cistron-office.nl>
In-Reply-To: <20010719.14393700@dap21.dapsys.ch>
X-Trace: ncc1701.cistron.net 995554727 9561 195.64.65.236 (19 Jul 2001 14:58:47 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Edouard Soriano <e_soriano@dapsys.com> wrote:
> I remember there is a solution to turn around this problem forcing LILO to
> configure 1GB saying, I think but not sure:
> 
> append='memory=1024'
> 
> I searched in the lilo doc for memory parameter definition, but as being
> coverd by append parameter I found nothing.

"mem=" is documented in the kernel documentation
(...linux/Documentation/i386/boot.txt):

  mem=<size>
        <size> is an integer in C notation optionally followed by K, M
        or G (meaning << 10, << 20 or << 30).  This specifies to the
        kernel the memory size.
  [snip]

HTH,
Ray
-- 
Does Kibo SEE the FNORDS?

