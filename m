Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbUDSPtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbUDSPtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:49:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41863 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264422AbUDSPth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:49:37 -0400
Message-ID: <4083F501.2070008@pobox.com>
Date: Mon, 19 Apr 2004 11:49:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tg3 driver - make use of binary-only firmware optional
References: <20040418135534.GA6142@andaco.de> <20040418180811.0b2e2567.davem@redhat.com> <20040419080439.GB11586@andaco.de> <20040419085809.GA585@wiggy.net>
In-Reply-To: <20040419085809.GA585@wiggy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:
> Previously Andreas Jochens wrote:
> 
>>Would the patch be acceptable if the firmware parts were kept in tg3.c
>>as they are now but #ifdef'd out when CONFIG_TIGON3_FIRMWARE is not set?
> 
> 
> Is there any reason for not using the hotplug firmware infrastructure?


Right now there is not a high enough "Just Works" value to do this.  The 
mechanisms for wide dissemination of necessary firmware, and automatic 
placement in initrd/initramfs, are not present yet.

This is a long term goal of all drivers that ship firmware, though.

	Jeff



