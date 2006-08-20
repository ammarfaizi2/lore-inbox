Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWHTUT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWHTUT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWHTUT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:19:58 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:2970 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S1751208AbWHTUT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:19:58 -0400
Message-ID: <44E8C578.3090507@student.ltu.se>
Date: Sun, 20 Aug 2006 22:26:32 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
CC: linux-kernel@vger.kernel.org, drzeus-sdhci@drzeus.cx
Subject: Re: [Patch] Signedness issue in drivers/net/phy/phy_device.c
References: <1156008815.18192.3.camel@alice> <44E7E112.3010500@student.ltu.se> <20060820183600.GA3431@alice>
In-Reply-To: <20060820183600.GA3431@alice>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sesterhenn / Snakebyte wrote:

>* Richard Knutsson (ricknu-0@student.ltu.se) wrote:
>  
>
>>Would it not be preferable to use a 's32' instead of an 'int'? After 
>>all, it seem 'val' needs to be 32 bits.
>>    
>>
>
>not sure, but wouldnt this collide with platforms where an int is 64
>Bits?
>  
>
Because of 'phy_read'? It shouldn't as long the returning value is 
within the range of the s32.

>Eric
>  
>
Richard
