Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTEZRsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTEZRsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:48:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15819
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261956AbTEZRsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:48:53 -0400
Subject: Re: Linux 2.4.21-rc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030522234613.GA2473@werewolf.able.es>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
	 <20030522234613.GA2473@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053968645.16695.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 May 2003 18:04:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-23 at 00:46, J.A. Magallon wrote:

> -	    dep_bool     '    Special FastTrak Feature' CONFIG_PDC202XX_FORCE
> +	    dep_bool     '    Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_IDEDMA_PCI
>  	    dep_tristate '    RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86

This fix is the wrong way around. Make it "bool" for now

