Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266180AbSKFWhk>; Wed, 6 Nov 2002 17:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266181AbSKFWhk>; Wed, 6 Nov 2002 17:37:40 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:15102 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S266180AbSKFWhj>; Wed, 6 Nov 2002 17:37:39 -0500
Date: Wed, 6 Nov 2002 17:44:18 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Robert Love <rml@tech9.net>
Cc: Manish Lachwani <manish@Zambeel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Regarding zerocopy implementation ...
Message-ID: <20021106174418.F18836@redhat.com>
References: <233C89823A37714D95B1A891DE3BCE5202AB183D@xch-a.win.zambeel.com> <1036619185.3405.1407.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1036619185.3405.1407.camel@phantasy>; from rml@tech9.net on Wed, Nov 06, 2002 at 04:46:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 04:46:24PM -0500, Robert Love wrote:
> On Wed, 2002-11-06 at 10:23, Manish Lachwani wrote:
> > Is there a zerocopy receive implementation in Linux? I know that FreeBSD
> > 5.0-CURRENT has such an implementation named zerocopy sockets and when used
> > with a Alteon Tigon II NIC with header splitting turned on in Firmware,
> > works well. Do we have any such implementation in Linux? Any reponse is
> > greatly appreciated ...
> 
> Yes, we have zero-copy networking if the device supports the requisite
> features and the driver is so coded.

But we do not perform zero copy receives to userland yet.

		-ben
