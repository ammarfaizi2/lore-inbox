Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267988AbRHBATq>; Wed, 1 Aug 2001 20:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267999AbRHBATg>; Wed, 1 Aug 2001 20:19:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48908 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267988AbRHBATZ>; Wed, 1 Aug 2001 20:19:25 -0400
Subject: Re: 2.4.2 ext2fs corruption status
To: adilger@turbolinux.com (Andreas Dilger)
Date: Thu, 2 Aug 2001 01:20:28 +0100 (BST)
Cc: mhd@gxt.com (Mohamed DOLLIAZAL), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Andreas Dilger" at Aug 01, 2001 04:15:52 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15S6E0-00084e-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It may be that Red Hat has already released a new kernel RPM since that
> time, or maybe you need to compile a new kernel.

The official VIA workaround fix is now in 2.4.6ac5 and 2.4.7ac*. The fixes
in the older kernels were mostly going to do the job but I dont know if they
were perfect for all cases

The -ac kernel tree also contains important fixes that avoid DMA timeouts
potentially causing disk corruption by forgetting to write sectors
