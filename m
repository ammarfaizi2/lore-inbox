Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVBQSgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVBQSgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 13:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVBQSgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 13:36:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5547 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261173AbVBQSg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 13:36:26 -0500
Message-ID: <4214E419.5060807@pobox.com>
Date: Thu, 17 Feb 2005 13:36:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Benjamin LaHaise <bcrl@kvack.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill include/linux/eeprom.h
References: <20050217144825.GJ24808@stusta.de>
In-Reply-To: <20050217144825.GJ24808@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch kills include/linux/eeprom.h .
> 
> Rationale:
> - it's only used by one single driver
> - most of this file are non-inline and non-static functions (sic)
> 
> This patch moves all required contents of this file into ns83820.c and 
> removes include/linux/eeprom.h (and makes setup_ee_mem_bitbanger 
> static).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

I would rather update other drivers to use it :)

	Jeff



