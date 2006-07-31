Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWGaHys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWGaHys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWGaHys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:54:48 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:36511 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1750926AbWGaHyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:54:47 -0400
Date: Mon, 31 Jul 2006 09:54:28 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       laurent.riffard@free.fr, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Message-ID: <20060731075428.GA24584@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
	laurent.riffard@free.fr, andrew.j.wade@gmail.com,
	linux-kernel@vger.kernel.org
References: <20060727015639.9c89db57.akpm@osdl.org> <44CCBBC7.3070801@free.fr> <20060731000359.GB23220@kroah.com> <200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060731033757.GA13737@kroah.com> <20060730212227.175c844c.akpm@osdl.org> <20060731043542.GA9919@kroah.com> <20060730215025.44292f9c.akpm@osdl.org> <20060731051547.GB29058@kroah.com> <20060730230033.cc4fc190.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730230033.cc4fc190.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 11:00:33PM -0700, Andrew Morton wrote:
> The impact is lower in this case because we've already trained our
> long-suffering users to expect udev to regularly break.

It has broken, even in 2.6.18-rc3, see http://lkml.org/lkml/2006/7/30/163
'2.6.18-rc3 does not like an old udev (071)' and beyond.

It now requires udev 079, in disaccordance with the Documentation/Changes
file.

This breaks Ubuntu LTS, which for some reason chose to ship udev 071.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
