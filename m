Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSKRRuk>; Mon, 18 Nov 2002 12:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSKRRuk>; Mon, 18 Nov 2002 12:50:40 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:47325 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264010AbSKRRuj>;
	Mon, 18 Nov 2002 12:50:39 -0500
Date: Mon, 18 Nov 2002 17:55:35 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dead & Dying interfaces
Message-ID: <20021118175535.GD15318@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 06:47:25PM +0000, Matthew Wilcox wrote:

 > This list is a combination of interfaces which have gone during 2.5 and
 > interfaces that should go during 2.7.  Think of it as a `updating your
 > driver/filesystem to sane code' guide.

Adding printk (KERN_DEBUG "Usage of check_region() is deprecated");
to such interfaces may be an idea. For some of them, however it
is probably a bad idea if the logs get flooded with zillions of warnings
each boot.  Maybe just for the "We really should purge this crap next
time" functions ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
