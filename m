Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285098AbRLFKvu>; Thu, 6 Dec 2001 05:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285108AbRLFKvl>; Thu, 6 Dec 2001 05:51:41 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:7040 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S285098AbRLFKve>; Thu, 6 Dec 2001 05:51:34 -0500
Date: Thu, 6 Dec 2001 12:54:57 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: APIC Error when doing apic_pm_suspend
In-Reply-To: <15374.22142.86391.322681@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.33.0112061254250.16671-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Mikael Pettersson wrote:

> No, 0x40 is an illegal vector error. It's a (semi-) known quirk in the P6 family
> of processors that you get this error when writing a null vector to any of the
> LVT entries, even if you are also setting the mask bit at the same time.
> Both the clear_local_APIC() call at PM suspend and the reinitialisation at PM
> resume can trigger this.
>
> The "error" is mostly harmless. Ignore it for now, I'll do a patch to silence it later.

Could you please CC me the patch.

Thanks,
	Zwane Mwaikambo


