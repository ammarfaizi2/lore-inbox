Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSK0Vn1>; Wed, 27 Nov 2002 16:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSK0Vn1>; Wed, 27 Nov 2002 16:43:27 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:52959 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264875AbSK0Vmx>;
	Wed, 27 Nov 2002 16:42:53 -0500
Date: Wed, 27 Nov 2002 21:47:24 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to list pci devices from userpace?  anything better than /proc/bus/pci/devices?
Message-ID: <20021127214724.GA31850@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
References: <3DE537FC.6090105@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DE537FC.6090105@nortelnetworks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 04:24:12PM -0500, Chris Friesen wrote:
 > 
 > I have a situation where the userspace app needs to be able to deal with 
 >  two different models of hardware, each of which uses a slightly 
 > different api.
 > 
 > Is there any way that I can query the pci vendor/device numbers without 
 > having to parse ascii files in /proc?

See pcilib. Part of pciutils. (Its on freshmeat)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
