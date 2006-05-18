Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWERPis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWERPis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWERPis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:38:48 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15747 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750933AbWERPir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:38:47 -0400
Message-ID: <446C9503.1020609@garzik.org>
Date: Thu, 18 May 2006 11:38:43 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Tejun Heo <htejun@gmail.com>, Jan Wagner <jwagner@kurp.hut.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: support for sata7 Streaming Feature Set?
References: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi> <4466D6FB.1040603@gmail.com> <Pine.LNX.4.58.0605162126520.31191@kurp.hut.fi> <446BD8F2.10509@gmail.com> <446C7435.2040809@rtr.ca>
In-Reply-To: <446C7435.2040809@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> The device driver has to know about it, at a minimum so that it can
> select a different EH protocol for the streams.  Which in turn means
> that the streaming commands should be known to the driver as well.

Different taskfile protocol, you mean?


> But how to handle it all nicely is the real question.
> A new block driver, if libata cannot handle it?

I seriously doubt writing a whole new ATA driver subsystem will fly :)

	Jeff



