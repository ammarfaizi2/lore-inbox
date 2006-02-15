Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWBOWM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWBOWM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWBOWM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:12:57 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:38327
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751319AbWBOWM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:12:56 -0500
Date: Wed, 15 Feb 2006 14:13:01 -0800
From: Greg KH <greg@kroah.com>
To: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stuck creating sysfs hooks for a driver..
Message-ID: <20060215221301.GA25941@kroah.com>
References: <43F2DE34.60101@designergraphix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F2DE34.60101@designergraphix.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 01:24:28PM +0530, Kaiwan N Billimoria wrote:
> Hello All,
> 
> I am in the process of porting a 2.4 temperature sensor device driver (the 
> National Semiconductor LM70CILD-3 temperature sensor eval board) to the 2.6 
> Linux kernel (specifically to v 2.6.15.3 <http://2.6.15.3>), with the 
> intention of submitting it for inclusion. All ok, except this: am stuck on 
> inserting an entry in /sys instead of /proc for the
> driver (as that is suggested as the new "correct" interface to userspace).

Have you read Documentation/hwmon/sysfs-interface?  I think that,
combined with using the hwmon class code is what you want to use here.

Hope this helps,

greg k-h
