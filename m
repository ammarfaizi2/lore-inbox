Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWCXBOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWCXBOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWCXBOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:14:44 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:11987
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932615AbWCXBOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:14:43 -0500
Date: Thu, 23 Mar 2006 17:13:49 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: Add support for virtual I2C adapters
Message-ID: <20060324011349.GC28500@kroah.com>
References: <Pine.LNX.4.44.0603231854270.29782-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0603231854270.29782-100000@gate.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 06:55:31PM -0600, Kumar Gala wrote:
> +EXPORT_SYMBOL(i2c_add_virt_adapter);
> +EXPORT_SYMBOL(i2c_del_virt_adapter);

EXPORT_SYMBOL_GPL() perhaps?

thanks,

greg k-h
