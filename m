Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268712AbRHCLNF>; Fri, 3 Aug 2001 07:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268933AbRHCLMy>; Fri, 3 Aug 2001 07:12:54 -0400
Received: from hera.cwi.nl ([192.16.191.8]:54948 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268712AbRHCLMp>;
	Fri, 3 Aug 2001 07:12:45 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 3 Aug 2001 11:12:52 GMT
Message-Id: <200108031112.LAA122587@vlet.cwi.nl>
To: david.balazic@uni-mb.si, linux-kernel@vger.kernel.org,
        testers-list@redhat.com
Subject: Re: Linux can't find partitions , again
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yesterday I did "nothing" (*) and then linux didn't boot anymore.
> * - I created a partition on the free part of the disk, but after a minute
> I changed my mind an deleted it.
> I used the Disk Administrator tools undwr win2000

Always interesting. Why don't you run

	sfdisk -l -uS -x /dev/hda

? You might teach us something about how win2000 handles partitions.

Andries


