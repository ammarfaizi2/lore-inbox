Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263052AbSJGOCt>; Mon, 7 Oct 2002 10:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263053AbSJGOCt>; Mon, 7 Oct 2002 10:02:49 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:18159 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263052AbSJGOCs>; Mon, 7 Oct 2002 10:02:48 -0400
Subject: Re: initio driver needs updating
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bart@etpmod.phys.tue.nl
Cc: jbinpg@shaw.ca, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210071110.g97BA1J18387@gum09.etpnet.phys.tue.nl>
References: <200210071110.g97BA1J18387@gum09.etpnet.phys.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 15:18:02 +0100
Message-Id: <1034000282.25098.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 12:09, bart@etpmod.phys.tue.nl wrote:
> Yeah, found the same problem. I am not the maintainer, but more than
> willing to take a shot at it. It has been a while since I rooted around
> in the kernel source, and, more importantly, I would like to use my
> CD-burner with 2.5 :-).

Good luck. The main thing it needs to do is use the pci mapping
interfaces (see Documentation/DMA-mapping.txt). That actually has
helpers for scsi stuff.

