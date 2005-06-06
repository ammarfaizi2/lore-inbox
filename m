Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVFFIUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVFFIUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 04:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVFFIUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 04:20:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28622 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261219AbVFFITy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 04:19:54 -0400
Subject: Re: [PROBLEM] aic7xxx: DV failed to configure device
From: Arjan van de Ven <arjan@infradead.org>
To: Denis Zaitsev <zzz@anda.ru>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20050606141638.A28532@ward.six>
References: <20050606141638.A28532@ward.six>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 10:19:45 +0200
Message-Id: <1118045986.5652.21.camel@laptopd505.fenrus.org>
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

On Mon, 2005-06-06 at 14:16 +0600, Denis Zaitsev wrote:
> I'm testing an Adaptec SCSI controller + an IBM drive.  All the things
> used to be fine before I had made the low-level format of the drive
> (thru the Ctrl-A Adaptec's menu).  And now after
> 
>         modprobe aic7xxx


you failed to mention which exact kernel you were using...
(that matters since the aic7xxx driver changes a lot over time, and
especially it changed recently in this area a lot)

