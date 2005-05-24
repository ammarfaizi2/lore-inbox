Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVEXVRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVEXVRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 17:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVEXVRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 17:17:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33693 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262192AbVEXVRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 17:17:05 -0400
Subject: RE: [PATCH 2.6.12-rc4-mm1 3/4] megaraid_sas: updating the driver
From: Arjan van de Ven <arjan@infradead.org>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Matt_Domsch@Dell.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <60807403EABEB443939A5A7AA8A7458B01399B22@otce2k01.adaptec.com>
References: <60807403EABEB443939A5A7AA8A7458B01399B22@otce2k01.adaptec.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 23:16:49 +0200
Message-Id: <1116969409.6280.42.camel@laptopd505.fenrus.org>
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


> I expect (or hope) the answer to be: always needs io_request_lock in
> 2.4, never needed the host_lock in 2.5+.

afaik in RHEL3 you don't need it either but are allowed to.


