Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVC1PaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVC1PaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVC1PaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:30:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24461 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261907AbVC1P3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:29:23 -0500
Subject: Re: [2.6 patch] SCSI: cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1112023305.5531.2.camel@mulgrave>
References: <20050327202139.GQ4285@stusta.de>
	 <1112023305.5531.2.camel@mulgrave>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 17:29:17 +0200
Message-Id: <1112023757.6003.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
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

On Mon, 2005-03-28 at 09:21 -0600, James Bottomley wrote:
\
> > - remove the following unused functions:
> >   - scsi.h: print_driverbyte
> >   - scsi.h: print_hostbyte
> > - #if 0 the following unused functions:
> >   - constants.c: scsi_print_hostbyte
> >   - constants.c: scsi_print_driverbyte
> 
> These are useful to those of us who debug drivers.

how about a CONFIG_SCSI_DRIVER_DEBUG ?



