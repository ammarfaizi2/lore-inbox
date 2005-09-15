Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965250AbVIOO1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbVIOO1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbVIOO1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:27:35 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:3304 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965250AbVIOO1e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:27:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SlqywfED1wXnHN23sfvgVPNXw7tup+jw44Mxbv/3bmCvdGNe3oCxRrJWSQS8xJP1fRb9pbWDxoPGEqNJr+ZhlLZOTjQE7Vfq8L8+u/2wxybTvwvf3Upsp1jKKQUw8+Q1wUKFrQ8/hGme7zpTnIQ404cQyi10XwoacYO35z2bxnI=
Message-ID: <d120d50005091507274946e1dd@mail.gmail.com>
Date: Thu, 15 Sep 2005 09:27:29 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 00/28] RFC/RFT: Input - sysfs integration
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>
In-Reply-To: <1126771147.28510.16.camel@station6.example.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050915070131.813650000.dtor_core@ameritech.net>
	 <1126771147.28510.16.camel@station6.example.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Dmitry,
> 
> > The following set of patches deals with converting input subsystem
> > to the driver model and intergrate it with sysfs. This allows us
> > to remove custom-made input hotplug handler and finally have an
> > option of netlink-only hotplug notifier.
> 
> do you have a GIT tree with all that changes that I can simply pull in
> for testing?
> 

Not yet, but I think I will set one up if there is a general approval
of the direction of the series.

-- 
Dmitry
