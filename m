Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946045AbWKJIe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946045AbWKJIe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946050AbWKJIez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:34:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:55456 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1946045AbWKJIez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:34:55 -0500
Date: Fri, 10 Nov 2006 14:49:44 +0900
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] Use dev_sysdata for ACPI and remove firmware_data
Message-ID: <20061110054944.GB9137@kroah.com>
References: <1163033916.28571.803.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163033916.28571.803.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 11:58:36AM +1100, Benjamin Herrenschmidt wrote:
> This patch changes ACPI to use the new dev_sysdata on x86 and x86_64 (is there
> any other arch using ACPI ?) to store it's acpi_handle. It also removes the
> firmware_data field from struct device as this was the only user.

Yeah!  I've wanted to drop firmware_data for a while now :)

thanks,

gre k-h
