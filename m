Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265753AbSKAU1S>; Fri, 1 Nov 2002 15:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265755AbSKAU1S>; Fri, 1 Nov 2002 15:27:18 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:35458 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265753AbSKAU1Q>;
	Fri, 1 Nov 2002 15:27:16 -0500
Date: Fri, 1 Nov 2002 20:31:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jos Hulzink <josh@stack.nl>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Robert Varga <nite@hq.alert.sk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 build failed with ACPI turned on
Message-ID: <20021101203121.GB2329@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jos Hulzink <josh@stack.nl>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	Robert Varga <nite@hq.alert.sk>, linux-kernel@vger.kernel.org
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A498@orsmsx119.jf.intel.com> <20021101194711.GB714@suse.de> <200211012221.56346.josh@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211012221.56346.josh@stack.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 10:21:56PM +0100, Jos Hulzink wrote:
 > Other issue: Are ACPI and APM not mutually exclusive ? If so, I would propose 
 > a selection box: <ACPI> <APM> <none> with related options shown below. Hmzz.. 
 > there the issue of the fact that ACPI is more than power management shows up 
 > again.

Whilst they can't both run at the same time, it's perfectly possible
(and useful) to build a kernel with both included. ACPI will quit
if APM is already running, so booting with apm=off turns the same
kernel into 'ACPI mode'

Quite useful for me right now, as currently my Vaio won't boot
an ACPI kernel if its on mains power for some reason. 8-)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
