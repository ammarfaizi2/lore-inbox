Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278967AbRKIAwn>; Thu, 8 Nov 2001 19:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278940AbRKIAwe>; Thu, 8 Nov 2001 19:52:34 -0500
Received: from e22.nc.us.ibm.com ([32.97.136.228]:34039 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278967AbRKIAwQ>; Thu, 8 Nov 2001 19:52:16 -0500
Date: Fri, 09 Nov 2001 16:51:09 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andreas Dilger <adilger@turbolabs.com>, aputhiya <aputhiya@temple.edu>
cc: linux-smp@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: APIC Cluster Model
Message-ID: <302322260.1005324669@mbligh.des.sequent.com>
In-Reply-To: <20011108150158.D9043@lynx.no>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Linux uses FLAT MODEL for setting up the IO APIC for SMP machines (Intel
>> IA-32  arch). I was wondering if the CLUSTER MODEL has been implemented
>> in any of  later SMP kernels?
> 
> Yes, the IBM folks implemented this for CONFIG_MULITQUAD.  I don't know
> the details, but it is in stock 2.4.13+ kernels at least.

Look for things switched on clustered_apic_mode - some of it is
specific to IBM NUMA-Q (and should probably be switched on
something else that's also triggered by CONFIG_MULTIQUAD),
but most of it is switching to clustered APIC mode.

If you have another machine that uses this mode, feel free to
mail me any questions you have about what I did.

Martin.

