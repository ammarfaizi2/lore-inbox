Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbTABNwj>; Thu, 2 Jan 2003 08:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbTABNwj>; Thu, 2 Jan 2003 08:52:39 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:53455 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261894AbTABNwj>;
	Thu, 2 Jan 2003 08:52:39 -0500
Date: Thu, 2 Jan 2003 13:59:28 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [TRIVIAL] [AGPGART]:  early agp init fix
Message-ID: <20030102135928.GA28043@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Antonino Daplas <adaplas@pol.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <1041514432.1003.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041514432.1003.30.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 09:34:04PM +0800, Antonino Daplas wrote:
 
 > intel_agp_init() must not be declared static for explicit early
 > initialization to work (ie i810fb).

Ahh, I was wondering why that was the odd one out.
Applied, with a comment added describing this so it doesn't
happen again 8-)

Thanks,

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
