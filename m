Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266927AbSL3LYf>; Mon, 30 Dec 2002 06:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbSL3LYf>; Mon, 30 Dec 2002 06:24:35 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:62147 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266927AbSL3LYe>;
	Mon, 30 Dec 2002 06:24:34 -0500
Date: Mon, 30 Dec 2002 11:31:22 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH 2.5.53] cpufreq: longhaul cleanup
Message-ID: <20021230113122.GC11633@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
References: <20021228231233.GB1310@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021228231233.GB1310@brodo.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 12:12:33AM +0100, Dominik Brodowski wrote:
 > Clean up searching code for best frequency and add some safety checks.

Looks ok from a cursory glance, but one thing I'm wondering is
if some of this code can be factored out a little. There seems to
be some duplication between the various CPU drivers.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
