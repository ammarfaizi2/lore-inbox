Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbRHAX2Q>; Wed, 1 Aug 2001 19:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267790AbRHAX2H>; Wed, 1 Aug 2001 19:28:07 -0400
Received: from ns.caldera.de ([212.34.180.1]:17353 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S267771AbRHAX14>;
	Wed, 1 Aug 2001 19:27:56 -0400
Date: Thu, 2 Aug 2001 01:27:55 +0200
Message-Id: <200108012327.f71NRti27028@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: kiwiunixman@yahoo.co.nz (Matthew Gardiner)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Caldera Special Start Up Screen
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010801.23102700@kiwiunixman.ihug.co.nz>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010801.23102700@kiwiunixman.ihug.co.nz> you wrote:
> I was able to get the initrd working, however, how do you get the special 
> graphical loader to work with the custom kernel? I am running linux 
> 2.4.7ac3 w/ ReiserFS. Hopefully, once that is out of the way, I will 
> start offering kernel upgrades via my personal website.

Apply the following patches from your COL source RPM to the kernel tree:

  o linux-silent-COL.patch
  o linux-vgaplan4-COL.patch

They are fairly version independand and should work with all 2.4 kernels.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
