Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSGZJX4>; Fri, 26 Jul 2002 05:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317432AbSGZJX4>; Fri, 26 Jul 2002 05:23:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:27892 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317429AbSGZJXz>; Fri, 26 Jul 2002 05:23:55 -0400
Subject: Re: 2.4.19-rc3-ac3 ide_map_buffer/ide_unmap_buffer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Charles R. Anderson" <cra@WPI.EDU>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020725193806.U7778@angus.ind.WPI.EDU>
References: <20020725193806.U7778@angus.ind.WPI.EDU>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 11:41:35 +0100
Message-Id: <1027680095.13428.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 00:38, Charles R. Anderson wrote:
> 
> Which one should I apply? I'm inclined to keep the Red Hat bits, since
> the ac3 ide_unmap_buffer does nothing.
> 
> [For anyone wondering, I have a new Dell with an Intel 845G chipset for
> which I would like DMA support, etc.  I'm attempting to merge
> 2.4.19-rc3-ac3 with Red Hat's patches.  If anyone has a simple patch for
> 82801DB IDE DMA support which applies to 2.4.18 I'd be much obliged.]

Thats a non trivial merge. I don't think there is anything in the base
RH that matters except for big (1Gb plus) servers that isnt in -ac. You
can also pick up the rawhide kernel if you are brave 

