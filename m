Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVB1PjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVB1PjV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVB1PjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:39:20 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:12283 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261653AbVB1PjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:39:07 -0500
From: Bernd Schubert <bernd-schubert@gmx.de>
To: "Benjamin L. Shi" <benjamin.shi@structurenet.com>
Subject: Re: swapper: page allocation failure. order:1, mode:0x20
Date: Mon, 28 Feb 2005 16:38:52 +0100
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <fa.hgi75u0.1cnmhaa@ifi.uio.no> <42233772.7020409@structurenet.com>
In-Reply-To: <42233772.7020409@structurenet.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502281638.54135.bernd-schubert@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Benjamin,

On Monday 28 February 2005 16:23, Benjamin L. Shi wrote:
> We've seen these, by adding the following tueables resolved the problem.
> More specifically, the lower zone protection made the difference.
>
> vm.vfs_cache_pressure=1000
> vm.lower_zone_protection=100
> vm.max_map_count = 32668
> vm.min_free_kbytes = 10000
>

many thanks, we will test this now and set those values on all of our 2.6. 
systems.

Thanks a lot again,
 Bernd
