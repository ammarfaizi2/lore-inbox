Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130449AbRCCLza>; Sat, 3 Mar 2001 06:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130451AbRCCLzU>; Sat, 3 Mar 2001 06:55:20 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:50698 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130449AbRCCLzI>;
	Sat, 3 Mar 2001 06:55:08 -0500
Date: Sat, 3 Mar 2001 12:54:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VT82C586B USB PCI card, Linux USB
Message-ID: <20010303125436.A803@suse.cz>
In-Reply-To: <200103030503.f2353PQ21936@513.holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103030503.f2353PQ21936@513.holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Sat, Mar 03, 2001 at 12:13:49AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03, 2001 at 12:13:49AM -0500, Michael Rothwell wrote:
> I have a USB PCI card, which shows up as this in `lspci`:
> 
> 00:09.0 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 04)
> 
> ... it appears that they tossed the whole southbridge chip onto a pci
> board, and disabled everything but USB.

No, they have a separate USB chip, but it has the same PCI ID as the
builtin silicon in the southbridge.

-- 
Vojtech Pavlik
SuSE Labs
