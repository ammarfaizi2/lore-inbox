Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWG2NJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWG2NJh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 09:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWG2NJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 09:09:37 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:18707 "EHLO
	smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751370AbWG2NJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 09:09:36 -0400
Date: Sat, 29 Jul 2006 15:09:34 +0200 (CEST)
From: Yuri van Oers <yvanoers@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI device order changed
In-Reply-To: <Pine.LNX.4.61.0607171143090.11447@yvahk01.tjqt.qr>
Message-ID: <20060729150554.R334-100000@xs3.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Jul 2006, Jan Engelhardt wrote:

> >Ok, but I think none of the above applies in this situation, because the
> >cards use the same driver (AIC7xxx).
>
> In which case the ... usual(!) ... behavior is "the lowest PCI
> slot/address" gets the first c0 (as in c0t0d0s0) and therefore the first
> disk spots sda, sdb, etc.
> But anything may happen :>

Indeed. I tracked the change to 2.6.13-rc4, which includes a patch to
always probe in bus order.

So I'll turn my machine off now and swap the cards.

Regards,
Yuri

