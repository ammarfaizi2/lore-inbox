Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268304AbTBMV0J>; Thu, 13 Feb 2003 16:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268306AbTBMV0J>; Thu, 13 Feb 2003 16:26:09 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:59806 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268304AbTBMV0H>;
	Thu, 13 Feb 2003 16:26:07 -0500
Date: Thu, 13 Feb 2003 21:31:43 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60-bk pdflush oops.
Message-ID: <20030213213143.GB24878@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030213205608.GB24109@codemonkey.org.uk> <20030213132300.065c33d0.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213132300.065c33d0.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 01:23:00PM -0800, Andrew Morton wrote:
 > That is a statically stored timer.  It would appear that some other timer
 > from some other random part of the kernel has got itself scribbled on.
 > 
 > Maybe networking?  

Possible given this is the box I'm seeing that NFS bug on.
Could even be both the same bug perhaps.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
