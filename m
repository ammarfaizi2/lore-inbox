Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSLNRRj>; Sat, 14 Dec 2002 12:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSLNRRj>; Sat, 14 Dec 2002 12:17:39 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:29580 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262604AbSLNRRi>;
	Sat, 14 Dec 2002 12:17:38 -0500
Date: Sat, 14 Dec 2002 17:25:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 cpufeatures.h
Message-ID: <20021214172507.GD2112@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Margit Schubert-While <margitsw@t-online.de>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021214124403.00ae5f00@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20021214124403.00ae5f00@pop.t-online.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 12:55:55PM +0100, Margit Schubert-While wrote:
 > #define X86_FEATURE_ACC         (0*32+29) /* Automatic clock control 
 > 
 > According to Intel specs, bit 29 is :
 > " TM  Thermal Monitor    The processor implements the thermal monitor 
 > automatic
 >   thermal control circuitry (TMM)"
 > 
 > The (wrong?) FEATURE ACC is used in
 > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
 > arch/i386/kernel/cpu/mcheck/p4.c

Its just different terminology for the same thing.

	Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
