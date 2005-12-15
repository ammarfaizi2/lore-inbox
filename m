Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbVLOCrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbVLOCrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVLOCrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:47:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11928 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030363AbVLOCrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:47:11 -0500
Date: Wed, 14 Dec 2005 21:47:07 -0500
From: Bill Nottingham <notting@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       katzj@redhat.com
Subject: Re: "block" symlink in sysfs for a multifunction device
Message-ID: <20051215024707.GA3097@devserv.devel.redhat.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
	katzj@redhat.com
References: <20051212134904.225dcc5d.zaitcev@redhat.com> <20051214055019.GA23036@kroah.com> <20051214152615.13b6b105.zaitcev@redhat.com> <20051214234255.GA3275@kroah.com> <20051214161018.254e75bb.zaitcev@redhat.com> <20051215004434.GA4148@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215004434.GA4148@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH (greg@kroah.com) said: 
> I don't understand, what exactly would you like to see in the block
> device's device directory?  With this patch, we correctly point back to
> all of the different block devices controlled by this device.
> 
> I'm curious as to why kudzu even cares about this?

Actually, it shouldn't be a problem.

> And, how does it handle things like mult-port serial devices, which have
> all of the multiple class device symlinks in one single device
> directory, just like this.

Ignores them entirely, of course. (kudzu at this point is used
solely in the installer.)

Bill
