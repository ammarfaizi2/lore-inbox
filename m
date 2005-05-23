Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVEWPAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVEWPAF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVEWO7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:59:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44013 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261733AbVEWO6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:58:33 -0400
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell
	BIOS update driver
From: Arjan van de Ven <arjan@infradead.org>
To: Abhay_Salunke@Dell.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED388@ausx2kmpc115.aus.amer.dell.com>
References: <367215741E167A4CA813C8F12CE0143B3ED388@ausx2kmpc115.aus.amer.dell.com>
Content-Type: text/plain
Date: Mon, 23 May 2005 16:58:27 +0200
Message-Id: <1116860307.6280.31.camel@laptopd505.fenrus.org>
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

On Mon, 2005-05-23 at 09:52 -0500, Abhay_Salunke@Dell.com wrote:
> Greg,
> > 
> > Also, what's wrong with using the existing firmware interface in the
> > kernel?
> request_firmware requires the $FIRMWARE env to be populated with the
> firmware image name or the firmware image name needs to be hardcoded
> within  the call to request_firmware

ok so far

> . Since the user is free to change
> the BIOS update image at will, it may not be possible if we use
> $FIRMWARE

it is, just have a sysfs file to let the user echo the firmware name
in , with a suitable default if he doesn't.


