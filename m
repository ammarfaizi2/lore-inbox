Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263104AbVFXP6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbVFXP6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVFXP6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:58:45 -0400
Received: from digitalimplant.org ([64.62.235.95]:43454 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S263135AbVFXP5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:57:19 -0400
Date: Fri, 24 Jun 2005 08:57:15 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices
 from userspace
In-Reply-To: <20050624051442.GB24621@kroah.com>
Message-ID: <Pine.LNX.4.50.0506240855460.24799-100000@monsoon.he.net>
References: <20050624051229.GA24621@kroah.com> <20050624051442.GB24621@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Jun 2005, Greg KH wrote:

> This adds a single file, "unbind", to the sysfs directory of every
> device that is currently bound to a driver.  To unbind the driver from
> the device, write anything to this file and they will be disconnected
> from each other.

Do you think it would be better to put the 'unbind' file in the driver's
directory and have it accept the bus ID of a device that it's bound to?
This would make it more similar to the complementary 'bind' functionality.


	Pat
