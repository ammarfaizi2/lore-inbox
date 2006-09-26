Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWIZTnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWIZTnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWIZTnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:43:19 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:25487 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932494AbWIZTnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:43:18 -0400
Message-ID: <451982D1.6000806@garzik.org>
Date: Tue, 26 Sep 2006 15:43:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: pata_serverworks oopses in latest -git
References: <20060926140016.54d532ba.diegocg@gmail.com>	<1159275010.11049.215.camel@localhost.localdomain>	<45194DAD.6060904@garzik.org> <20060926212939.69b52f0d.diegocg@gmail.com>
In-Reply-To: <20060926212939.69b52f0d.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> El Tue, 26 Sep 2006 11:56:29 -0400,
> Jeff Garzik <jeff@garzik.org> escribió:
> 
>> Diego, does the attached patch help?
> 
> Yes and no :) It fixes that problem but I hit another oops, but this
> time it's triggered because it hits the BUG() at:
> 
> static int serverworks_pre_reset(struct ata_port *ap) {
> [...]
>         BUG();
>         return -1;      /* kill compiler warning */

I'll punt this one to Alan :)

Can you provide using with 'lspci -vvvxxxn' output, as root?

	Jeff



