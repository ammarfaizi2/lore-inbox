Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUHSJiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUHSJiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUHSJiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:38:22 -0400
Received: from unthought.net ([212.97.129.88]:6585 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S264503AbUHSJgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:36:46 -0400
Date: Thu, 19 Aug 2004 11:36:45 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Heinz Mauelshagen <mauelshagen@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: *** Announcement: dmraid 1.0.0-rc3 ***
Message-ID: <20040819093645.GZ27443@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Heinz Mauelshagen <mauelshagen@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20040818190610.GA6279@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818190610.GA6279@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 09:06:10PM +0200, Heinz Mauelshagen wrote:
> 
>                *** Announcement: dmraid 1.0.0-rc3 ***
> 
> dmraid 1.0.0-rc3 is available at
> http://people.redhat.com:/~heinzm/sw/dmraid/ in source, source rpm and i386 rpm.
> 
> dmraid (Device-Mapper Raid tool) discovers, [de]activates and displays
> properties of software RAID sets (ie. ATARAID) and contained DOS
> partitions using the device-mapper runtime of the 2.6 kernel.
> 
> The following ATARAID types are supported on Linux 2.6:
> 
> Highpoint HPT37X
> Highpoint HPT45X
> Intel Software RAID
> Promise FastTrack
> Silicon Image Medley

Just a question; if it has already been answered or is somehow
irrelevant I apologize for my ignorance in advance...   :)

Why not add Linux Software RAID (md) support as well?  That way we'd
finally be able to get rid of the MD-outside-DM code.

And maybe kill the kernel auto-detection of MD devices while we're at it
(ok, that's probably 2.7 material as it will break a *lot* of systems)

-- 

 / jakob

