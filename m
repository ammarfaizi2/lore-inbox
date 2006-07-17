Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWGQJoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWGQJoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 05:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWGQJox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 05:44:53 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:5561 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750708AbWGQJow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 05:44:52 -0400
Date: Mon, 17 Jul 2006 11:44:32 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Yuri van Oers <yvanoers@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI device order changed
In-Reply-To: <20060716210643.B25160-100000@xs3.xs4all.nl>
Message-ID: <Pine.LNX.4.61.0607171143090.11447@yvahk01.tjqt.qr>
References: <20060716210643.B25160-100000@xs3.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Ok, but I think none of the above applies in this situation, because the
>cards use the same driver (AIC7xxx).
>
In which case the ... usual(!) ... behavior is "the lowest PCI 
slot/address" gets the first c0 (as in c0t0d0s0) and therefore the first 
disk spots sda, sdb, etc.
But anything may happen :>


Jan Engelhardt
-- 
