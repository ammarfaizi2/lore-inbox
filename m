Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266979AbSK2I1D>; Fri, 29 Nov 2002 03:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbSK2I1D>; Fri, 29 Nov 2002 03:27:03 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:50123 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S266979AbSK2I1C>; Fri, 29 Nov 2002 03:27:02 -0500
Date: Fri, 29 Nov 2002 09:34:14 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Jens-Christian Skibakk <jens@cultus.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Radeon DRM oops in 2.4.20-rc4-ac1
Message-ID: <20021129083414.GD20066@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
References: <3DE72215.7000504@cultus.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DE72215.7000504@cultus.no>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 09:15:17AM +0100, Jens-Christian Skibakk wrote:
> Nov 29 08:54:37 debian kernel: Call Trace:    [radeon_cp_init+120/164] 
> [radeon_ioctl+216/228] [sys_ioctl+605/628] [system_call+51/56]
> Nov 29 08:54:37 debian kernel:
> Nov 29 08:54:37 debian kernel: Code: 89 10 57 e8 3c f0 ff ff 57 56 e8 89 
> f4 ff ff c7 47 44 00 00
> 
> 
> The Oops happens when i start the X-Window system with DRI enabled.

could you try the link below?
http://marc.theaimsgroup.com/?l=linux-kernel&m=103839583129724&w=2

> Hardware:
> Dell Inspiron 4150 with ATI Radeon 7500 32MB running at 1400x1050
...
> #
> # DRM 4.1 drivers
> #
> CONFIG_DRM_NEW=y
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_R128 is not set
> CONFIG_DRM_RADEON=y
