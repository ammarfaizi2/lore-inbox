Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274133AbRJDPUX>; Thu, 4 Oct 2001 11:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274171AbRJDPUO>; Thu, 4 Oct 2001 11:20:14 -0400
Received: from dsl092-078-153.bos1.dsl.speakeasy.net ([66.92.78.153]:24704
	"EHLO greynode.net") by vger.kernel.org with ESMTP
	id <S274133AbRJDPT7>; Thu, 4 Oct 2001 11:19:59 -0400
Message-Id: <200110041520.f94FKCn01275@greynode.net>
Content-Type: text/plain; charset=US-ASCII
From: "Benjamin S. Scarlet" <lk-receive@greynode.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
Date: Thu, 4 Oct 2001 11:20:12 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15mk45-0005Li-00@the-village.bc.nu>
In-Reply-To: <E15mk45-0005Li-00@the-village.bc.nu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 September 2001 06:55 pm, Alan Cox wrote:
> Long answer "I have been chasing a specific problem with OSB4, seagate
> drives and UDMA corruption. We can reliably reproduce it and see it on one
> set of machines. Serverworks cannot reproduce it elsewhere"

> I would thus be very interested if the current -ac "hardware just did
> something impossibly stupid" trap is hit.

Are you otherwise interested in machines seeing this problem? I have a 
candidate. I'm running a SuperMicro 370DL3 with a Seagate ST320423A. For the 
sake of simplicity I turned off DMA and filled the whole drive full of 
zeroes. I see data corruption (non-zero data) on an otherwise inactive 
machine just reading the drive back with "od", if I have DMA on with some 
settings (udma2 in particular fails). Currently I'm using just kernel 2.4.9, 
but if it would be useful I could run tests with kernels of your choosing.

	Ben Scarlet
