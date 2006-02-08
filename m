Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWBHSsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWBHSsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWBHSsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:48:25 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:6065 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1030379AbWBHSsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:48:24 -0500
Date: Wed, 8 Feb 2006 10:48:16 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: dipankar@in.ibm.com, paul.mckenney@us.ibm.com,
       linux-usb-devel@lists.sourceforge.net
Subject: [patch 00/03] EXPORT_SYMBOL_GPL_FUTURE()
Message-ID: <20060208184816.GA17016@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we don't have a way to show people that some kernel symbols
will be changed in the future from EXPORT_SYMBOL() to
EXPORT_SYMBOL_GPL().  As we all know, not everyone reads the
Documentation/feature_removal.txt file, so we need a bigger way to
remind people.

Here's a series of three patches that adds this functionality, and
marks the RCU and USB subsystems with them.

I'll be adding these to my kernel trees to have them show up in the -mm
releases for testing.

thanks,

greg k-h
