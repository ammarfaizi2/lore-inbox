Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVFHKIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVFHKIC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVFHKIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:08:02 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10138 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262158AbVFHKHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:07:51 -0400
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
From: Arjan van de Ven <arjan@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Brian Gerst <bgerst@didntduck.org>, christoph <christoph@scalex86.org>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050608100056.GA331@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>
	 <20050607194123.GA16637@infradead.org>
	 <Pine.LNX.4.62.0506071258450.2850@ScMPusgw>
	 <1118177949.5497.44.camel@laptopd505.fenrus.org>
	 <42A61227.9090402@didntduck.org>
	 <20050608100056.GA331@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jun 2005 12:07:25 +0200
Message-Id: <1118225246.5655.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
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

On Wed, 2005-06-08 at 12:00 +0200, Jörn Engel wrote:
> On Tue, 7 June 2005 17:31:19 -0400, Brian Gerst wrote:
> > 
> > It doesn't really matter.  .rodata isn't actually mapped read-only. 
> > Doing so would break up the large pages used to map the kernel.
> 
> Can you confirm that for every architecture?  Or just i386?

does it matter? it's supposed to be read only, only sometimes that's not
enforced unfortunately.


