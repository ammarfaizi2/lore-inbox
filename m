Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266164AbRGDUBh>; Wed, 4 Jul 2001 16:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266163AbRGDUB0>; Wed, 4 Jul 2001 16:01:26 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:9989 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266161AbRGDUBQ>; Wed, 4 Jul 2001 16:01:16 -0400
Message-Id: <200107042003.f64K36a00572@collie.ncptiddische.net>
Content-Type: text/plain; charset=US-ASCII
From: Nils Holland <nils@nightcastleproductions.org>
Organization: NightCastle Productions
To: linux-kernel@vger.kernel.org
Subject: ide-scsi problem in 2.4.6?!?
Date: Wed, 4 Jul 2001 22:03:05 +0200
X-Mailer: KMail [version 1.2.9]
NCP-Opt: Powered by Linux
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

there seems to be a problem in the 2.4.6. kernel, but unluckily, I have no 
idea what it is. Seriously: Let me tell you the whole story:

I tend to burn a lot of CDs using my IDE CD-writer. In order to accomplish 
that, I'm using cdrecord 1.11a04, of course in conjunction with the ide-scsi 
emulation in the kernel. Now, up to 2.4.5 this has always worked fine - with 
2.4.5 alone, I have probably burned a few dozen CDs without any problems.

Today I updated to 2.4.6. I did not update any other software on my computer, 
only the kernel. When I now try to burn a CD with cdrecord, it fails in about 
80% of all cases (yes, I've already wasted about 5 CDs trying to figure out 
what's wrong).

What happens is the following: The burn process starts fine, but then, 
suddenly, after about 24 MB have been written, the process suddenly stops, 
giving me a bunch of SCSI error messages on the screen, including one that 
tells me something about "Streaming lost..."

Now, I'm not a hard-core programmer, but I've still tried to figure out where 
the problem lies. Obviously, since everything worked fine under 2.4.5, and 
since the problem only occured after updating to 2.4.6, while everything else 
on my machine remained the same, it seems as if the problem has something to 
do with the kernel. What comes to my mine first is, of course, the ide-scsi 
stuff. However, since I'm using a VIA-based Athlon system, I also wouldn't 
exclude the possibility of this being another manifestation of the VIA-bug.

Currently, I seem to be able to work around the problem by turning the 
BURN-Proof feature of my CD-burner on. I've never used it before, and what I 
can see from the information cdrecord shows on the screen, the buffer is not 
nearly empty when the burn process suddenly stops, but still BURN-Proof seems 
to help. Just note that I never had any problems with kernels < 2.4.6 that 
required me to use BURN-Proof.

I guess that if this is really a problem with the kernel (and it really seems 
to be), then others will also see this problem. If so, I'd be glad to hear 
about it. Again: I'm not a kernel-hacker, but I hope that if we're really 
facing a serious problem here, enough information can be gathered so that 
someone can fix it.

Greetings
Nils

-- 
----------------------------------------------------------
Nils Holland - nils@nightcastleproductions.org
NightCastle Productions - Linux in Tiddische, Germany
http://www.nightcastleproductions.org
"Give the heavens above more than just a passing glance
And when you get the choice to sit it out or dance - 
I hope you dance!"
----------------------------------------------------------

