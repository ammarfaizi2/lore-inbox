Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVGaEpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVGaEpz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 00:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVGaEpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 00:45:54 -0400
Received: from mail.dvmed.net ([216.237.124.58]:21208 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261616AbVGaEpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 00:45:52 -0400
Message-ID: <42EC577C.8080407@pobox.com>
Date: Sun, 31 Jul 2005 00:45:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/8139too.c: rework the debug levels
References: <20050722211309.GP3160@stusta.de>
In-Reply-To: <20050722211309.GP3160@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Looking at this driver, I wondered why there were two different 
> #define's controlling the debug output of the driver.


Because debug output and runtime checks are two different concepts, two 
different behaviors.

	Jeff


