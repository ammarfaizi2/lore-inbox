Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWGPT2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWGPT2h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbWGPT2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:28:37 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:29705 "EHLO
	smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP
	id S932067AbWGPT2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:28:36 -0400
Date: Sun, 16 Jul 2006 21:28:34 +0200 (CEST)
From: Yuri van Oers <yvanoers@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI device order changed
In-Reply-To: <Pine.LNX.4.61.0607161751590.3179@yvahk01.tjqt.qr>
Message-ID: <20060716210643.B25160-100000@xs3.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Jul 2006, Jan Engelhardt wrote:

> >Hard disks are sda thru sdd, the devices start at sde. That is, up until I
> >booted 2.6.17 _with_ the external devices attached. The kernel swapped
> >the order of the cards: devices start at sda, and the disks come after,
> >which means it can't find / on sda.
>
> It usually depends on link time order (when compiled in) or module load
> order (with initrd), both of which, esp. the latter, can be fine-tuned to
> the user's needs.
>
> Also note CONFIG_BLK_DEV_OFFBOARD.

Ok, but I think none of the above applies in this situation, because the
cards use the same driver (AIC7xxx).


Regards,
Yuri van Oers
(please CC me, I'm not on the list)

