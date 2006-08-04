Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161363AbWHDTpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161363AbWHDTpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWHDTpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:45:47 -0400
Received: from enyo.dsw2k3.info ([195.71.86.239]:31439 "EHLO enyo.dsw2k3.info")
	by vger.kernel.org with ESMTP id S932605AbWHDTpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:45:47 -0400
Message-ID: <44D3A3DF.9000307@citd.de>
Date: Fri, 04 Aug 2006 21:45:35 +0200
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Stability-Problem of EHCI with a larger number
 of USB-Hubs/Devices
References: <44C126C3.9000105@citd.de> <200608041108.19549.david-b@pacbell.net>
In-Reply-To: <200608041108.19549.david-b@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> Did you try with 2.6.18-rc3?  There's a Kconfig option for an
> improved interrupt scheduler, which might help especially with
> all those low speed devices.

I hadn't but i just did.
(I guess you meant CONFIG_USB_EHCI_TT_NEWSCHED=y)

The behaviour was different, every light went on and the syslog went 
silent. I could switch on one of the HDDs and i could see it in 
/proc/partitions. But then everything completly broke down and syslog 
was flooded after some time all lights went out.

Do you want/need the syslog?





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

