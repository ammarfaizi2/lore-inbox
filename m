Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292971AbSCNPGg>; Thu, 14 Mar 2002 10:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311148AbSCNPG0>; Thu, 14 Mar 2002 10:06:26 -0500
Received: from dialup-7-5.net.ic.ac.uk ([155.198.8.101]:61568 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S292971AbSCNPGK>; Thu, 14 Mar 2002 10:06:10 -0500
Date: Thu, 14 Mar 2002 15:11:18 +0000
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5.6] support for NCR voyager
Message-ID: <20020314151118.A11178@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203120404.g2C44mV12800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203120404.g2C44mV12800@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 11:04:48PM -0500, James Bottomley wrote:
 > The major change since the last voyager patch is that the voyager code is 
 > split out into an arch/i386/voyager directory which hooks into the main line 
 > code rather than being mixed with it.
 > 
 > The patch is in two parts this time:  The i386 sub-architecture split is 
 > separated from the addition of the voyager components

 Hi James,
  I just took a quick look at your work on splitting this stuff up, and I
  think it's definitly heading in the right direction. As to integrating this,
  I think it's probably best to get Patrick Mochel's other related work
  included first. See what he's done so far at..
   http://kernel.org/pub/linux/kernel/people/mochel/patches/patch-linux-v2.5.6-pm1.bz2
  His patch and yours touch various files for more or less the same reason.

  Patrick still has some bits to finish off here, but combined the two patchsets
  will bring some much needed sanity to various parts of arch/i386/ 

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
