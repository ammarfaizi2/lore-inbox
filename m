Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbRGKRRc>; Wed, 11 Jul 2001 13:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267369AbRGKRRR>; Wed, 11 Jul 2001 13:17:17 -0400
Received: from colin.muc.de ([193.149.48.1]:37389 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S267368AbRGKRQ7>;
	Wed, 11 Jul 2001 13:16:59 -0400
Message-ID: <20010711191721.38160@colin.muc.de>
Date: Wed, 11 Jul 2001 19:17:21 +0200
From: Andi Kleen <ak@muc.de>
To: Herve Masson <herve@mindstep.com>
Cc: linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: PROBLEM: csum_partial() / i386 does not handle unaligned address with empty region properly
In-Reply-To: <065f01c10a3f$cbe849a0$0400a8c0@swan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <065f01c10a3f$cbe849a0$0400a8c0@swan>; from Herve Masson on Wed, Jul 11, 2001 at 09:29:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 09:29:26PM +0200, Herve Masson wrote:
> Hi,
> 
> I hope I knock on the right door...

AFAIK the standard kernel never passes zero length to csum_partial so there
is no bug in it. If IPVS does that it probably needs to be fixed.
I would report it to the IPVS maintainers.


-Andi
