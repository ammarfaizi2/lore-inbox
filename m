Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266184AbSKFWlU>; Wed, 6 Nov 2002 17:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266185AbSKFWlU>; Wed, 6 Nov 2002 17:41:20 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:34463 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S266184AbSKFWlT>;
	Wed, 6 Nov 2002 17:41:19 -0500
Date: Wed, 6 Nov 2002 23:47:55 +0100
From: bert hubert <ahu@ds9a.nl>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Regarding zerocopy implementation ...
Message-ID: <20021106224755.GA10956@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <233C89823A37714D95B1A891DE3BCE5202AB183D@xch-a.win.zambeel.com> <1036619185.3405.1407.camel@phantasy> <20021106174418.F18836@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106174418.F18836@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 05:44:18PM -0500, Benjamin LaHaise wrote:

> > Yes, we have zero-copy networking if the device supports the requisite
> > features and the driver is so coded.
> 
> But we do not perform zero copy receives to userland yet.

It has been opted that sendfile with reversed arguments could function as
'recvfile' and be renamed to 'copyfd' or something more generic like that.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
