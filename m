Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWGIPYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWGIPYo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 11:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWGIPYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 11:24:44 -0400
Received: from Maxwell.derobert.net ([207.188.193.82]:23688 "EHLO
	Maxwell.derobert.net") by vger.kernel.org with ESMTP
	id S1161024AbWGIPYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 11:24:43 -0400
Message-ID: <44B11FA1.8070905@suespammers.org>
Date: Sun, 09 Jul 2006 11:24:17 -0400
From: Anthony DeRobertis <asd@suespammers.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Stephen Hemminger <shemminger@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       341801@bugs.debian.org, kevin@sysexperts.com
Subject: Re: skge error; hangs w/ hardware memory hole
References: <20060703205238.GA10851@deprecation.cyrius.com> <20060707141843.73fc6188@dxpl.pdx.osdl.net> <200607072328.51282.ak@suse.de>
In-Reply-To: <200607072328.51282.ak@suse.de>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAKlBMVEVTAABbAQBsAACAAQCV
 AAC3DwTXPhTrZiLyjiroi133tCn53UX51n/45bb7J7XrAAACZ0lEQVQ4y2WTz07bQBDGlz5BHF6g
 cfoAxeu+QHYd7rDjwD1eK1eq7AbUU6XGVpRroTxBKE8ABs6oKr2itiHv0pldh/zpSJai/WVm55v5
 lgVBsLufFaoT4q8GWwWBGC4VJxBsgjaXqeJRa5MEQRNBLxMupe2KvWk4ELZ5fPxVcB6GYbyHtBm/
 J9AkkGaSf0CWRFjx3YErFRKADJIjUBIURFx2CIQEZKL1eGQ/ApyNVSJFwwOOIAWAdKBktxiKVuhB
 G0E6VhJD8Fjxjm+XzmN59EVy7vrCzwNOhaA3RBA58cux4LlMTy9QoD9/1c7j7rBXDkHU540VSExu
 QGLtjQRGlQzgDMPWRgIB0EouwWq6MYozr2BtU1ImOQH+P0hHmZJ1t+sggTwDSSmbq/UAAJexBQAG
 j9ZolfRbGwD/PHjWJv1TiG2QWioFMtoCvcEzXS5dv2tdAXaLy66FrAPtgKgVrkCqrQZSvi59J3jL
 dD690CtAaAc995mZT+faA29eH7sH7LY0mS/l/e4ijE/YQ2XAXR6LcJkSSjhhi9+GLsdQ9dbR/kPY
 Y4vK6IwA9GufoLe6hxGbz06xX4y8L8hwzsv7irP59VPhARxyT9BRINni/psborOKcym9CgD287sl
 kJdjDzhZGbthTzOrNaR5mXkxnGxzLjirClyf1tbUKrmE41kmIlaVEwKX2ACNmOrkGl89q+6vsFY+
 fTSZA2RMcjh7+DWzNh8V2IIbDN4wJiezxd2VtbZE+X4w+E4zhVLZ4i+CSWFIpAPQc/2xeXVd2MmN
 XQLnvwRH8jK/u5m+FD9w+K4WzuCs0Ab+Ad5UBbueJrnMAAAAAElFTkSuQmCC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Is that a board with VIA chipset?

Yep.

> 
> VIA doesn't seem to support PCI accesses with addresses >4GB and they also
> don't have a working GART IOMMU.
> 
> It will likely work with iommu=force

I'll give this a try.... I do get a line in dmesg which reads:

PCI-DMA: Disabling IOMMU.
