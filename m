Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288327AbSAQIg0>; Thu, 17 Jan 2002 03:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288325AbSAQIgQ>; Thu, 17 Jan 2002 03:36:16 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:62453 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288333AbSAQIgB>; Thu, 17 Jan 2002 03:36:01 -0500
Message-Id: <200201170008.g0H08IPo001389@tigger.cs.uni-dortmund.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: Two issues with 2.4.18pre3 on PPC 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Wed, 16 Jan 2002 12:10:58 EST." <20020116121058.B5940@thyrsus.com> 
Date: Thu, 17 Jan 2002 01:08:17 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:

[...]

> However, the *right* fix is
> 
> derive PPC_RTC from RTC & ((S390==n and APUS==n) or (APUS!=n and CONFIG_4xx))
> 
> eliminating PPC_RTC as a separate question entirely and hiding a platform 
> detail.  

PPC is for PowerPC chips, right? Then deducing it is a PPC from it not
being totally unrelated systems is... weird. And will break the moment the
next architecture is included, because nobody will know to update such
rules.
-- 
Horst von Brand			     http://counter.li.org # 22616
