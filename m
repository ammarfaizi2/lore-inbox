Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSKATnY>; Fri, 1 Nov 2002 14:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265364AbSKATnY>; Fri, 1 Nov 2002 14:43:24 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:9602 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265339AbSKATnX>;
	Fri, 1 Nov 2002 14:43:23 -0500
Date: Fri, 1 Nov 2002 19:47:11 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Jos Hulzink'" <josh@stack.nl>, Robert Varga <nite@hq.alert.sk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 build failed with ACPI turned on
Message-ID: <20021101194711.GB714@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	'Jos Hulzink' <josh@stack.nl>, Robert Varga <nite@hq.alert.sk>,
	linux-kernel@vger.kernel.org
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A498@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A498@orsmsx119.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 11:37:26AM -0800, Grover, Andrew wrote:
 > ACPI implements PM but that's not all it implements. Is making CONFIG_PM
 > true if ACPI or APM are on a viable option? I think that would more
 > accurately reflect reality.
 > 
 > Or can we get rid of CONFIG_PM?

I'm not sure of places that do it off the top of my head, but
CONFIG_PM would save us having to do ugly CONFIG_APM || CONFIG_ACPI
tests.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
