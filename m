Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271483AbRHPFHq>; Thu, 16 Aug 2001 01:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271476AbRHPFHg>; Thu, 16 Aug 2001 01:07:36 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:39695 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S271478AbRHPFHU>; Thu, 16 Aug 2001 01:07:20 -0400
Date: Thu, 16 Aug 2001 13:08:46 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: <jes@trained-monkey.org>
cc: <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 64 bit bug in video1394.c
In-Reply-To: <200108160449.f7G4nu619552@savage.trained-monkey.org>
Message-ID: <Pine.LNX.4.33.0108161307180.1401-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can't you just redefine int to unsigned long for 64-bit system?

Thanks,
Jeff
[ jchua@fedex.com ]

On Thu, 16 Aug 2001 jes@trained-monkey.org wrote:

> Hi
>
> drivers/message/i2o/i2o_block.c cpu flags in 'int' which breaks on 64
> bit boxes.
>
> Here's a patch.
>

