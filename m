Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264083AbRFFSxE>; Wed, 6 Jun 2001 14:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264062AbRFFSwz>; Wed, 6 Jun 2001 14:52:55 -0400
Received: from iris.mc.com ([192.233.16.119]:64438 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S264020AbRFFSwh>;
	Wed, 6 Jun 2001 14:52:37 -0400
From: Mark Salisbury <mbs@mc.com>
To: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>, Kurt Roeckx <Q@ping.be>
Subject: Re: Break 2.4 VM in five easy steps
Date: Wed, 6 Jun 2001 14:40:41 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.3.96.1010606184337.19288A-100000@virgo.cus.cam.ac.uk>
In-Reply-To: <Pine.SOL.3.96.1010606184337.19288A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Message-Id: <0106061450480H.00684@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jun 2001, Dr S.M. Huen wrote:
> The whole screaming match is about whether a drastic degradation on using
> swap with less than the 2*RAM swap specified by the developers should lead
> one to conclude that a kernel is "broken".

I would argue that any system that performs substantially worse with swap==1xRAM
than a system with swap==0xRAM is fundamentally broken.  it seems that w/
todays 2.4.x kernel, people running programs totalling LESS THAN their physical
dram are having swap problems.  they should not even be using 1 byte of swap.

the whole point of swapping pages is to give you more memory to execute
programs.

if I want to execute 140MB of programs+kernel on a system with 128 MB of ram,
I should be able to do the job effectively with ANY amount of "total memory"
exceeding 140MB. not some hokey 128MB RAM + 256MB swap just because the kernel
it too fscked up to deal with a small swap file.

-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**------------------------------------------------*/

