Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbTENTOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbTENTOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:14:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38052
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261250AbTENTOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:14:40 -0400
Subject: Re: 2.5.69-mm5: sb1000.c: undefined reference to `alloc_netdev'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, hch@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, fventuri@mediaone.net
In-Reply-To: <20030514103115.465d18a8.akpm@digeo.com>
References: <20030514012947.46b011ff.akpm@digeo.com>
	 <20030514144727.GG1346@fs.tum.de>  <20030514103115.465d18a8.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052936763.2492.57.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2003 19:26:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-14 at 18:31, Andrew Morton wrote:
> +	/* New-style flags. */
> +	/* This seems bogus */
> +	dev->flags = IFF_POINTOPOINT|IFF_NOARP;
> +

Its far from bogus. Its an rx only cable modem device. Your uplink is
modem and you dont want to arp on it

