Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbTINTJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 15:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbTINTJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 15:09:24 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:48288 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261255AbTINTJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 15:09:23 -0400
Subject: Re: 1:1 M:N threading
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Breno <brenosp@brasilsec.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <000b01c37af0$402349a0$f8e4a7c8@bsb.virtua.com.br>
References: <000b01c37af0$402349a0$f8e4a7c8@bsb.virtua.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063566480.2131.16.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sun, 14 Sep 2003 20:08:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-14 at 19:44, Breno wrote:
> Hi.
> 
> What kind of threading kernel 2.4 and 2.6 do ? 1:1 or M:N ?

The kernel doesn't impose a specific model although its certainly
strongly oriented to 1:1 threading models by simply making the kernel
threading/locking so efficient the M:N stuff isnt worth the overhead

