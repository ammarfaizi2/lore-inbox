Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRIFVzs>; Thu, 6 Sep 2001 17:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbRIFVzj>; Thu, 6 Sep 2001 17:55:39 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.27]:31843 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S267196AbRIFVzS>; Thu, 6 Sep 2001 17:55:18 -0400
Message-ID: <3B97EFE0.30703@chello.nl>
Date: Thu, 06 Sep 2001 23:51:28 +0200
From: Gerbrand van der Zouw <g.vanderzouw@chello.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: tegeran@home.com, linux-kernel@vger.kernel.org
Subject: Re: K7/Athlon optimizations again. (The sacrifices worked??) (VIA KT133A chipset)
In-Reply-To: <01090613553103.00465@c779218-a>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Knight wrote:

> I'd be curious if it's an issue with only one brand or release of BIOS
> then.


Hi,

I am one of the person reporting success with some BIOS version over 
another. I have been experimenting some more and found the following:

Sytem:
Board: MSI K7T Turbo (MS-6330)
CPU: Athlon 1.2 GHz
Video: NVidia GF2
Kernel: 2.4.6ac5 with the patch Kurt Garloff posted here some while ago 
(can't find the right reference)

Ranking from very unstable to stable:
Very unstable: 2.4.6 plain, Award V2.7 Bios (i.e. without the 
Southbridge bug solved the official VIA way)
Unstable: 2.4.6ac5 with or without Kurt's patch, Award V2.7 Bios
Stable (up to now): 2.4.6ac5 with Kurt's patch and Award V2.8 Bios.

The key factor seemed to be the BIOS. The MSI website says that the 
following things changed between release 2.7 and 2.8:
- Fix STR Fail on MS-6330Lite.
- Fix 3Dmark 2001 sometimes halt
- Fix K7T Turbo Limited cannot adjust vcore

Only the second fix seems applicable to my mobo, but the description 
does not give a clue.

I hope that someone can distill something useful out of this. I am of 
course willing to try some other combination of parameters if this would 
help finding the source of the problem.


Cheers,

Gerbrand van der Zouw




