Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTJJSLv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTJJSLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:11:51 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:21930 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263129AbTJJSLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:11:50 -0400
Date: Fri, 10 Oct 2003 19:11:33 +0100
From: Dave Jones <davej@redhat.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test7] cpufreq longhaul trouble
Message-ID: <20031010181133.GB32600@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jurgen Kramer <gtm.kramer@inter.nl.net>,
	linux-kernel@vger.kernel.org
References: <1065784536.2071.3.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065784536.2071.3.camel@paragon.slim>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 01:15:37PM +0200, Jurgen Kramer wrote:
 > Hi,
 > 
 > It seems that longhaul support in 2.6.0-test7 is still not working
 > properly...:-(. 
 > 
 > 
 > longhaul: VIA C3 'Ezra' [C5C] CPU detected. Longhaul v2 supported.
 > longhaul: Bogus values Min:0.000 Max:0.000. Voltage scaling disabled.
 > longhaul: MinMult=5.0x MaxMult=6.0x
 > longhaul: FSB: 0MHz Lowestspeed=0MHz Highestspeed=0MHz

Puzzling, its as if all your MSRs are returning zero.
What does x86info -a think ?
(http://www.codemonkey.org.uk/projects/x86info if you don't have it).

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
