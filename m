Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUDSM6r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbUDSM6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:58:46 -0400
Received: from main.gmane.org ([80.91.224.249]:61664 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264398AbUDSM6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:58:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Bevand <bevand_m@epita.fr>
Subject: Re: Sensors (W83627HF) in Tyan S2882
Date: Mon, 19 Apr 2004 14:56:58 +0200
Message-ID: <c60ids$nsf$1@sea.gmane.org>
References: <20040419120132.GP23938@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213.41.133.51
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040326
X-Accept-Language: en-us, en
In-Reply-To: <20040419120132.GP23938@fi.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
> 	Hello, world!\n
> 
> 	I have two systems with Tyan S2882 boards (K8S Pro). The sensors chip
> is Winbond w83627hf according to the mainboard documentation.  The w83627hf
> driver can read values from the sensors, but apparently not all values.
> The board has six fan connectors (two labeled CPU1 fan and CPU2 fan,
> and four chassis fans). BIOS displays the fan status correctly for all fans,
> so all fans are connected to the sensors chip. However, there are only three
> fans listed in /sys/devices/platform/i2c-1/1-0290.

On the S2885 (not your model), 2 fans are handled by the w83627hf, and 4 others
by an adt7463. I see that the S2882 has an adm1027, maybe this is the chip that
handles your 3 others fans ?

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.

