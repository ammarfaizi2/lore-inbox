Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275345AbTHNSuE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275356AbTHNSuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:50:03 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:45662 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S275345AbTHNStO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:49:14 -0400
Date: Thu, 14 Aug 2003 19:48:38 +0100
From: Dave Jones <davej@redhat.com>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via KT400 agpgart issues
Message-ID: <20030814184838.GB10901@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Mark Watts <m.watts@eris.qinetiq.com>, linux-kernel@vger.kernel.org
References: <200308141025.12747.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308141025.12747.m.watts@eris.qinetiq.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 10:25:12AM +0100, Mark Watts wrote:

 > Ok, I _am_ using the nVidia modules (on 2.4.21) but the fact that the agpgart 
 > driver can't sense my agp apature size is concerning... (its set to 256MB in 
 > the bios)
 > 
 > 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 
 > 16 19:03:09 PDT 2003
 > Linux agpgart interface v0.99 (c) Jeff Hartmann
 > agpgart: Maximum main memory to use for agp memory: 439M
 > agpgart: Detected Via Apollo Pro KT400 chipset
 > agpgart: unable to determine aperture size.
 > 0: NVRM: AGPGART: unable to retrieve symbol table
 > 
 > I'm running a GeForce FX 5600 128Mb with AGP 3.0 support enabled.
 > It seems to run ok, but its slower than the Ti 4200-4x I took out by a larger 
 > margin than it really should be (according to the benchmarks I've seen 
 > scattered through the internet.)
 > I'm also running with the Local APIC turned on (it doesnt seem to break 
 > anything).
 > 
 > Is anything actually broken or is this nothing to worry about?

Caused due to lack of AGP 3.x support in 2.4
See 2.6.0-test

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
