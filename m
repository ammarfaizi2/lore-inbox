Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131171AbRBXCrq>; Fri, 23 Feb 2001 21:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131166AbRBXCrg>; Fri, 23 Feb 2001 21:47:36 -0500
Received: from smtp2.ihug.co.nz ([203.109.252.8]:22029 "EHLO smtp2.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S131164AbRBXCr2>;
	Fri, 23 Feb 2001 21:47:28 -0500
Message-Id: <200102240247.f1O2l1G07847@sucky.fish>
Subject: Re: [rfc] Near-constant time directory index for Ext2
From: Ralph Loader <suckfish@ihug.co.nz>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Andries.Brouwer@cwi.nl, Linux-kernel@vger.kernel.org,
        kaih@khms.westfalen.de
In-Reply-To: <20010223233717.B13627@win.tue.nl>
In-Reply-To: <UTC200102230152.CAA138669.aeb@vlet.cwi.nl>
	<200102232143.f1NLhG202360@sucky.fish>  <20010223233717.B13627@win.tue.nl>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 24 Feb 2001 15:47:01 +1300
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries,

> is very little interaction to start with. And the final AND that
truncates

> to the final size of the hash chain kills the high order bits.
> No good.

I didn't realise you were bit-masking down to the required size.

Yes, it would be pretty useless in that case.

Ralph.


> 
> Andries
> 
> 
> 

