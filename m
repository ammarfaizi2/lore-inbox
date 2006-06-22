Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWFVAck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWFVAck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWFVAck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:32:40 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:47285 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932157AbWFVAcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:32:39 -0400
Message-ID: <4499E524.4060206@garzik.org>
Date: Wed, 21 Jun 2006 20:32:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
CC: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: Using libata for ICH5 PATA
References: <20060622004811.0009937c@werewolf.auna.net>
In-Reply-To: <20060622004811.0009937c@werewolf.auna.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallón wrote:
> What do I need to let libata drive the ICH5 pata ?

Probably just ATA_ENABLE_PATA at the top of include/linux/libata.h.

BTW Note there may be problems with sata_promise PATA port support ATM...

	Jeff


