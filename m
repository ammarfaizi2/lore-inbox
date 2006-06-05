Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750732AbWFEXDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWFEXDA (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 19:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWFEXDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 19:03:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750732AbWFEXC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 19:02:59 -0400
Date: Mon, 5 Jun 2006 19:02:48 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulkf@microgate.com
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605230248.GE3963@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	paulkf@microgate.com
References: <20060603232004.68c4e1e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603232004.68c4e1e3.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2006 at 11:20:04PM -0700, Andrew Morton wrote:
 > 
 > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/

WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol alloc_hdlcdev
WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_close
WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_set_carrier
WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol register_hdlc_device
WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_open
WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_ioctl
WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol unregister_hdlc_device

(19:02:21:root@northwood:mm3)# grep SYNCLINK .config
CONFIG_SYNCLINK_CS=m
CONFIG_SYNCLINK_CS_HDLC=y
(19:02:25:root@northwood:mm3)# grep HDLC .config
CONFIG_HDLC=m
# CONFIG_HDLC_RAW is not set
# CONFIG_HDLC_RAW_ETH is not set
# CONFIG_HDLC_CISCO is not set
# CONFIG_HDLC_FR is not set
# CONFIG_HDLC_PPP is not set
CONFIG_HISAX_HDLC=y
CONFIG_SYNCLINK_CS_HDLC=y


		Dave

-- 
http://www.codemonkey.org.uk
