Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTBTRNs>; Thu, 20 Feb 2003 12:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTBTRNr>; Thu, 20 Feb 2003 12:13:47 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:52402 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265197AbTBTRNN>;
	Thu, 20 Feb 2003 12:13:13 -0500
Date: Thu, 20 Feb 2003 17:35:38 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Casey Lancour <cjlancour@link.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8x AGP under linux?
Message-ID: <20030220173538.GA21860@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Casey Lancour <cjlancour@link.com>, linux-kernel@vger.kernel.org
References: <3E5509C8.DFE6FD34@link.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5509C8.DFE6FD34@link.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 11:00:56AM -0600, Casey Lancour wrote:
 > Does anyone know the status to 8x agp support under linux?
 > I am using the Granite bay 7205 chipset and I cant get my geforce4 card
 > to use agpgart or nvidia's agp support, it seems to be defaulting to pci
 > mode (not even using 4x agp).
 > I do a:

For 2.4, there is a patch for that chipset (that didnt get merged
to mainline). 2.5 has it supported out-of-the-box, but likely
breaks with your binary nvidia driver.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
