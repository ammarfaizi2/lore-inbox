Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbREZW7G>; Sat, 26 May 2001 18:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262009AbREZW65>; Sat, 26 May 2001 18:58:57 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261864AbREZW6r>;
	Sat, 26 May 2001 18:58:47 -0400
Date: Sat, 26 May 2001 19:04:57 +0100 (BST)
From: Dave Gilbert <gilbertd@treblig.org>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5: Duplicate PCI devices (new pciutils fixed it)
In-Reply-To: <15119.56639.163937.257003@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10105261850530.750-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, David S. Miller wrote:

> 
> Dave Gilbert writes:
>  > /proc/pci seems to be only listing it once.
> 
> lspci uses /prov/bus/pci/${BUS}/${DEVICE}
> so likely it is showing up twice there.

Hmm nope - /proc/bus/pci has two entries '00' and devices
Devices has 5 lines in it; corresponding to the real 5 devices.
The 00 directory has 5 files in it.

Hmm - ah - cancel the report - I've just got pciutils 2.1.8 down and it is
now happy.  Should there be a version ref for pciutils in
Documentation/Changes?

Dave

-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

