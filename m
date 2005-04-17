Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVDQJEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVDQJEV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 05:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVDQJEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 05:04:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20926 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261287AbVDQJES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 05:04:18 -0400
Subject: Re: DRM not working with 2.6.11.5
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Dave Airlie <airlied@gmail.com>,
       "ross@lug.udel.edu" <ross@jose.lug.udel.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050416164155.GA23306@redhat.com>
References: <20050416070925.GA1237@jose.lug.udel.edu>
	 <21d7e99705041601476a147251@mail.gmail.com>
	 <20050416164155.GA23306@redhat.com>
Content-Type: text/plain
Date: Sun, 17 Apr 2005 11:04:11 +0200
Message-Id: <1113728652.17394.3.camel@laptopd505.fenrus.org>
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


> Adam Jackson was looking into this a few days ago by making
> the generic agpgart.o send hotplug events to trigger a load
> of the submodules. If he comes up with something I'll throw
> it at -mm if it looks sane.


is that needed? If the agp submodules advertise a list of pci id's isn't
that enough to get them auto loaded ?

(that works for all other modules in the kernel... ;)

