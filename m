Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268849AbUJKMEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268849AbUJKMEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268851AbUJKMEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:04:39 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:59888 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268849AbUJKMEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:04:21 -0400
Message-ID: <1a50bd3704101105046e66538c@mail.gmail.com>
Date: Mon, 11 Oct 2004 17:34:20 +0530
From: Ricky lloyd <ricky.lloyd@gmail.com>
Reply-To: Ricky lloyd <ricky.lloyd@gmail.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Subject: Re: [PATCH] Fix readw/writew warnings in drivers/net/wireless/hermes.h
Cc: Cal Peake <cp@absolutedigital.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev Mailing List <netdev@oss.sgi.com>, proski@gnu.org,
       hermes@gibson.dropbear.id.au
In-Reply-To: <416A7484.1030703@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.61.0410110702590.7899@linaeum.absolutedigital.net>
	 <416A7484.1030703@portrix.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Isn't the correct fix to declare iobase as (void __iomem *) ?
> 

Earlier today i had posted a patch which mainly fixes this same
problem with lotsa scsi
drivers and tulip drivers. I wondered the same "shouldnt all the addrs
be declared as
void __iomem* ??". 

-- 
-> Ricky
