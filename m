Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315792AbSEJD7v>; Thu, 9 May 2002 23:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315793AbSEJD7u>; Thu, 9 May 2002 23:59:50 -0400
Received: from wire.cadcamlab.org ([156.26.20.181]:37893 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S315792AbSEJD7u>; Thu, 9 May 2002 23:59:50 -0400
Date: Thu, 9 May 2002 22:59:46 -0500
To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH & call for help: Marking ISA only drivers
Message-ID: <20020510035946.GX4049@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Andi Kleen]
> - bool ' Other IDE chipset support' CONFIG_IDE_CHIPSETS
> + # assume no ISA -> also no VLB
> + dep_bool ' Other ISA/VLB IDE chipset support' CONFIG_IDE_CHIPSETS CONFIG_ISA

  + dep_bool ' Other ISA/VLB IDE chipset support' CONFIG_IDE_CHIPSETS $CONFIG_ISA

Oh yeah, for "2.5 Political Correctness" you might also s,IDE,ATA,...

Peter
