Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbTABMZf>; Thu, 2 Jan 2003 07:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTABMZf>; Thu, 2 Jan 2003 07:25:35 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:34255 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261527AbTABMZe>;
	Thu, 2 Jan 2003 07:25:34 -0500
Date: Thu, 2 Jan 2003 12:31:02 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au, hch@infradead.org
Subject: Re: RFC/Patch - Implode devfs
Message-ID: <20030102123102.GA26479@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au,
	hch@infradead.org
References: <20030101165121.A3091@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030101165121.A3091@baldur.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 04:51:21PM -0800, Adam J. Richter wrote:
 > The most
 > significant except that I'm aware of is the ability to create a plain
 > file with custom file operations, which is done the Memory Type Range
 > Register code, but that code also provides a proc interface for the
 > same thing, and I think the proc interface is what everyone uses right
 > now anyhow.

There is some userspace code out there doing ioctls on /dev/mtrr
The testgart app uses it, and I *think* thats what X uses.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
