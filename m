Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbVLHWnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbVLHWnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbVLHWnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:43:15 -0500
Received: from [81.2.110.250] ([81.2.110.250]:58827 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932682AbVLHWnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:43:14 -0500
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kumar Gala <galak@gate.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Grover <andrew.grover@intel.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
In-Reply-To: <Pine.LNX.4.44.0512081606060.24134-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0512081606060.24134-100000@gate.crashing.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Dec 2005 22:42:19 +0000
Message-Id: <1134081739.17102.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-08 at 16:13 -0600, Kumar Gala wrote:
> I'm actually searching for any examples of drivers that deal with the 
> issues related to DMA'ng directly two and from user space memory.

Look at drivers/media/video for several examples. Essentially in 2.6
get_user_pages() gives you page structs and pins the pages you need.



