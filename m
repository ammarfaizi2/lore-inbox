Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVF2P4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVF2P4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVF2P4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:56:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:11212 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261528AbVF2P4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:56:10 -0400
Date: Wed, 29 Jun 2005 08:55:52 -0700
From: Greg KH <greg@kroah.com>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Message-ID: <20050629155552.GA23485@kroah.com>
References: <20050629202640.GA3975@abhays.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629202640.GA3975@abhays.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 03:26:40PM -0500, Abhay Salunke wrote:
> This patch adds a new function to firmware_calss.c request_firmware_nowait_nohotplug . 
> The dell_rbu driver uses this call to create entries in /sys/class/firmware. 

No, this patch is your whole driver and the firmware changes all
together.  Please split this up into at least two different patches so
we can review them easier.

thanks,

greg k-h
