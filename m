Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVBXJal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVBXJal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVBXJal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:30:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17051 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261853AbVBXJad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:30:33 -0500
Subject: Re: kernel BUG at mm/rmap.c:483!
From: Arjan van de Ven <arjan@infradead.org>
To: "Ammar T. Al-Sayegh" <ammar@kunet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004501c51a52$c4200380$7101a8c0@shrugy>
References: <009d01c519e8$166768b0$7101a8c0@shrugy>
	 <1109192040.6290.108.camel@laptopd505.fenrus.org>
	 <003001c519f1$031afc00$7101a8c0@shrugy>
	 <1109196074.6290.116.camel@laptopd505.fenrus.org>
	 <007d01c519f9$7c9a5f50$7101a8c0@shrugy>
	 <1109234333.6530.19.camel@laptopd505.fenrus.org>
	 <004501c51a52$c4200380$7101a8c0@shrugy>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 10:30:29 +0100
Message-Id: <1109237429.6530.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
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


> I guess I can no longer monitor the processor temperature and
> such after preventing i2c from loading, 

yup

> but what what's the
> penalty of preventing microcode from loading? a performance
> hit?

not even that; in theory a few cpu bugs may have been fixed. Nobody
really knows since there's no changelog for the microcode..


