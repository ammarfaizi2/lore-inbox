Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318510AbSGZVaY>; Fri, 26 Jul 2002 17:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318511AbSGZVaY>; Fri, 26 Jul 2002 17:30:24 -0400
Received: from ns.suse.de ([213.95.15.193]:58885 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318510AbSGZVaY>;
	Fri, 26 Jul 2002 17:30:24 -0400
Date: Fri, 26 Jul 2002 23:33:40 +0200
From: Dave Jones <davej@suse.de>
To: Cort Dougan <cort@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix APM notify of apmd for on-AC/on-battery transitions
Message-ID: <20020726233339.D21176@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Cort Dougan <cort@fsmlabs.com>, linux-kernel@vger.kernel.org
References: <20020726143345.E13656@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020726143345.E13656@host110.fsmlabs.com>; from cort@fsmlabs.com on Fri, Jul 26, 2002 at 02:33:45PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 02:33:45PM -0600, Cort Dougan wrote:
 > This was tested on a Sony Vaio z505js, model PCG-5201 and it works
 > beautifully.  I'm told other Vaio notebooks have this same problem.

But not all Vaio's. My z600 (which is what they sold the z505 series as in .eu)
for example behaves correctly when I plug in/pull out the power cord
repeatedly.

We might be better off special casing 'known bad' models in the
DMI blacklist instead of assuming carte blanche that all vaio's are bad.
Might even come down to a specific BIOS version that's at fault.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
