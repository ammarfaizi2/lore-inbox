Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbTCKTYK>; Tue, 11 Mar 2003 14:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbTCKTYK>; Tue, 11 Mar 2003 14:24:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46798 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261558AbTCKTYJ>;
	Tue, 11 Mar 2003 14:24:09 -0500
Date: Tue, 11 Mar 2003 20:31:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Would the real 82801E_9 please stand up. (fwd)
Message-ID: <20030311193112.GA1295@suse.de>
References: <20030311192945.GA16212@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311192945.GA16212@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11 2003, Adrian Bunk wrote:
> The issue described in Dave's mail below is still present:
> 
> 2.4.21-pre5-ac1:
> #define PCI_DEVICE_ID_INTEL_82801E_9    0x2459
> #define PCI_DEVICE_ID_INTEL_82801E_11   0x245B
> 
> 
> 2.5.64-ac3:
> #define PCI_DEVICE_ID_INTEL_82801E_9    0x245b
> #define PCI_DEVICE_ID_INTEL_82801E_11   PCI_DEVICE_ID_INTEL_82801E_9
> 
> 
> Jens:
> The patch that did the
>   #define PCI_DEVICE_ID_INTEL_82801E_11   PCI_DEVICE_ID_INTEL_82801E_9
> in 2.5 was sent by you, could you comment on this issue?

This was during the nasty 2.4-ac IDE merge I did in 2.5, so I wouldn't
trust that particular change completely. The 2.4.21-pre5-ac1 is most
likely the correct one.

-- 
Jens Axboe

