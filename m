Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVAHPqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVAHPqH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 10:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVAHPqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 10:46:07 -0500
Received: from colin2.muc.de ([193.149.48.15]:29957 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261192AbVAHPqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 10:46:01 -0500
Date: 8 Jan 2005 16:46:00 +0100
Date: Sat, 8 Jan 2005 16:46:00 +0100
From: Andi Kleen <ak@muc.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: YhLu@tyan.com, Matt_Domsch@dell.com, discuss@x86-64.org,
       jamesclv@us.ibm.com, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050108154600.GA75857@muc.de>
References: <200501080237.j082booI005302@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501080237.j082booI005302@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 03:37:50AM +0100, Mikael Pettersson wrote:
> On Fri, 7 Jan 2005 22:12:00 +0100, Andi Kleen wrote:
> >On Fri, Jan 07, 2005 at 01:14:24PM -0800, YhLu wrote:
> >> After keep the bsp using 0, the jiffies works well. Werid?
> >
> >Probably a bug somewhere.  But since BSP should be always 
> >0 I'm not sure it is worth tracking down.
> 
> I hope by "0" you're referring to a Linux kernel defined
> software value and _not_ what the HW or BIOS conjured up!

No, I'm refering to the APIC ID configured by the BIOS. 

> Never trust a BIOS to DTRT.

I won't complicate the x86-64 code to work around non existant
theoretical BIOS issues.

-Andi
