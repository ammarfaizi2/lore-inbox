Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbUKRKXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbUKRKXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbUKRKWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:22:45 -0500
Received: from colino.net ([213.41.131.56]:46582 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262694AbUKRKUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:20:00 -0500
Date: Thu, 18 Nov 2004 11:19:20 +0100
From: Colin Leroy <colin.lkml@colino.net>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug_path no longer exported
Message-ID: <20041118111920.153e00d7@pirandello>
In-Reply-To: <419C743E.8090309@triplehelix.org>
References: <20041117203139.7c9f5e95.colin@colino.net>
	<20041117214824.GA1291@kroah.com>
	<20041117231253.1ec92e6f.colin@colino.net>
	<20041117222340.GA4494@kroah.com>
	<419C743E.8090309@triplehelix.org>
X-Mailer: Sylpheed-Claws 0.9.12cvs158.2 (GTK+ 2.4.0; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Nov 2004 at 02h11, Joshua Kwan wrote:

Hi, 

> Actually, orinoco_usb in current Orinoco CVS has support for some of
> these devices and I'm using one right now. The driver works pretty well
> but I'm not sure whether orinoco_usb supports many prism2_usb devices
> the same way orinoco_cs supports many prism2_cs devices.

No, doesn't work with prism2 usb devices. Half the functions are dummy
functions returning -EOPNOTSUPP.

I wish I was employed to do linux development so I could spend the 
necessary time to do such things...

-- 
Colin
