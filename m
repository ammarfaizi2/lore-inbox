Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbTBTQat>; Thu, 20 Feb 2003 11:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbTBTQat>; Thu, 20 Feb 2003 11:30:49 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:31922 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265786AbTBTQas>;
	Thu, 20 Feb 2003 11:30:48 -0500
Date: Thu, 20 Feb 2003 16:53:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Sowadski, Craig Harold (UMR-Student)" <sowadski@umr.edu>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 amd speculative caching
Message-ID: <20030220165307.GA19372@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Sowadski, Craig Harold (UMR-Student)" <sowadski@umr.edu>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <A5D66E6B6F478B48A3CEF22AA4B9FCA3012E55@umr-mail1.umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A5D66E6B6F478B48A3CEF22AA4B9FCA3012E55@umr-mail1.umr.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 01:13:28PM -0600, Sowadski, Craig Harold (UMR-Student) wrote:

 > If it helps, here is my hardware config:
 > 
 > 	AMD Duron 1300MHZ
 > 	MSI K7T Turbo-2
 > 	ATI Radeon 7500 w/64mb
 > 	Redhat 8.0

Are you using the ATi firegl drivers ? If so, thats likely the
problem. (They ship an agpgart based upon 2.4.16 which lacks
the fixes needed).

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
