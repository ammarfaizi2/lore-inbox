Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTFETuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 15:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbTFETuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 15:50:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59616 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264940AbTFETuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 15:50:20 -0400
Date: Thu, 5 Jun 2003 13:05:13 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Stephen Hemminger <shemminger@osdl.org>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] typo in new class_device_release
In-Reply-To: <20030605112641.7cb00f93.shemminger@osdl.org>
Message-ID: <Pine.LNX.4.44.0306051304290.13077-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jun 2003, Stephen Hemminger wrote:

> There is a typo in the current 2.5.70 bk version of class_device_release that
> was not there in my original patch.  By confusing the class and the class_device,
> the release function oops.  cd->release is always the function itself (class_device_release),
> cls->release is the one setup for the class (net_class in my case).

Bah, sloppy fixup..

Thanks,


	-pat

