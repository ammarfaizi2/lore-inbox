Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVCBOga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVCBOga (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVCBOfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:35:55 -0500
Received: from [195.23.16.24] ([195.23.16.24]:36584 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262321AbVCBOdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:33:06 -0500
Message-ID: <4225CE8C.70706@grupopie.com>
Date: Wed, 02 Mar 2005 14:32:44 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: BZ Benny <bennybbz@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module Vs app?
References: <20050302142433.12493.qmail@web26604.mail.ukl.yahoo.com>
In-Reply-To: <20050302142433.12493.qmail@web26604.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BZ Benny wrote:
> Hi,
> 
> I have an app wich run in the user space.
> I want to create a virtual network device for catching
> data under the IP layer and sending data to IP layer.
> I want to creaate such a second eth0.
> 
> I know how we can do this with /linux/netdevice.h
> but how can we do that from the user space?

I think you want a TUN device.

Read Documentation/networking/tuntap.txt

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
