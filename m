Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267701AbRGPVBG>; Mon, 16 Jul 2001 17:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267700AbRGPVA5>; Mon, 16 Jul 2001 17:00:57 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:61824 "EHLO
	porkkala.cs159246.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S267702AbRGPVAv>; Mon, 16 Jul 2001 17:00:51 -0400
Message-ID: <3B5355F5.B0ECF8FA@pp.htv.fi>
Date: Tue, 17 Jul 2001 00:00:37 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <E15LopT-0004Cm-00@the-village.bc.nu> <3B51C864.C98B61DE@namesys.com> <01071523304400.06482@starship> <3B53221B.28B8D5A1@pp.htv.fi> <3B533D98.B9D1074@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> 
> infinitely long, they used a base size of 1 byte, but we could use a base 
> size of 32 bits, and limit it to 64 bits rather than allowing infinite 
> scaling) seem like more conservative coding.

I think we should use either 32, 64 or 128 bits (or other 2^x) but not
fiddle with something like 48 bits. I believe we lose more than we gain from
added complexity.

Ok, 128 bits sounds like an insane amount, but so did 2 TB in early 80's.

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
