Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbTH1Wt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264240AbTH1Wt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:49:28 -0400
Received: from 64.221.211.208.ptr.us.xo.net ([64.221.211.208]:2495 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S264295AbTH1Wt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:49:27 -0400
Subject: Re: [ANNOUNCE] netplug, a daemon that handles network cables
	getting plugged in and out
From: "Bryan O'Sullivan" <bos@keyresearch.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <20030828224553.GC23528@werewolf.able.es>
References: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com>
	 <20030828215417.GA22215@werewolf.able.es> <3F4E8373.1040204@pobox.com>
	 <20030828224553.GC23528@werewolf.able.es>
Content-Type: text/plain
Message-Id: <1062110960.12285.94.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 28 Aug 2003 15:49:21 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 15:45, J.A. Magallon wrote:

> That would be very nice, but there is still a problem.
> Does netlink solve the fact that there are cards (at least in 2.4)
> that do not support any detection method:

netlink doesn't work through the ioctl interface at all.  If a card is
capable of reporting that its flags include IFF_UP or IFF_RUNNING via
the netlink interface, then netplug will work.

	<b

