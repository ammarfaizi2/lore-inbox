Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVFIVQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVFIVQk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 17:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVFIVQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 17:16:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58054 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262473AbVFIVQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 17:16:28 -0400
Subject: Re: ipw2100: firmware problem
From: Arjan van de Ven <arjan@infradead.org>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, pavel@ucw.cz, vda@ilport.com.ua,
       abonilla@linuxwireless.org, jgarzik@pobox.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, ipw2100-admin@linux.intel.com
In-Reply-To: <42A8AE2A.4080104@linux.intel.com>
References: <200506090909.55889.vda@ilport.com.ua>
	 <20050608.231657.59660080.davem@davemloft.net>
	 <20050609104205.GD3169@elf.ucw.cz>
	 <20050609.125324.88476545.davem@davemloft.net>
	 <42A8AE2A.4080104@linux.intel.com>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 23:15:54 +0200
Message-Id: <1118351754.5508.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-09 at 16:01 -0500, James Ketrenos wrote:
> I don't know if all the distributions have moved away from this model. 
> If they have and the devices are brought up regardless of link, then
> going back to delaying radio initialization until the open() is called
> is workable. 

wouldn't you want that anyway for power saving reasons?


