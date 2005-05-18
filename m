Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVERKcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVERKcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 06:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVERKch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 06:32:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1505 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262154AbVERKcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 06:32:31 -0400
Subject: Re: 2.6 jiffies
From: Arjan van de Ven <arjan@infradead.org>
To: linux <kernel@wired-net.gr>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <004601c55b94$5ea29d50$0101010a@dioxide>
References: <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
	 <1116256279.4154.41.camel@localhost>
	 <20050516111408.GA21145@mail.shareable.org>
	 <1116301843.4154.88.camel@localhost>
	 <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
	 <20050517012854.GC32226@mail.shareable.org>
	 <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu>
	 <1116360352.24560.85.camel@localhost>
	 <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu>
	 <1116399887.24560.116.camel@localhost>
	 <1116400118.24560.119.camel@localhost>
	 <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu>
	 <001b01c55b92$1d09c6e0$0101010a@dioxide>
	 <1116411888.6572.18.camel@laptopd505.fenrus.org>
	 <004601c55b94$5ea29d50$0101010a@dioxide>
Content-Type: text/plain
Date: Wed, 18 May 2005 12:32:28 +0200
Message-Id: <1116412348.6572.21.camel@laptopd505.fenrus.org>
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

On Wed, 2005-05-18 at 13:28 +0300, linux wrote:
> ok.i see what u mean.
> But should this value on a stable version be 0 again???

why? 
"the absolute value has no meaning" -> why would "0" be special ???
Answer: It's not. And actually -5 minutes is more useful than 0 because
it keeps helping finding bugs... why do you want it to start at 0 ?


