Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbULVI3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbULVI3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 03:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbULVI3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 03:29:31 -0500
Received: from canuck.infradead.org ([205.233.218.70]:22026 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261870AbULVI31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 03:29:27 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Arjan van de Ven <arjan@infradead.org>
To: Arne Caspari <arnem@informatik.uni-bremen.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20041220132012.GA6046@localhost>
References: <20041220015320.GO21288@stusta.de>
	 <41C694E0.8010609@informatik.uni-bremen.de>
	 <1103544944.4133.7.camel@laptopd505.fenrus.org>
	 <20041220132012.GA6046@localhost>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 09:29:17 +0100
Message-Id: <1103704157.4131.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 14:20 +0100, Arne Caspari wrote:
> Reply to the mail from Arjan van de Ven (arjan@infradead.org):
> 
> > On Mon, 2004-12-20 at 10:01 +0100, Arne Caspari wrote:
> > > Adrian,
> > > 
> > > Some of these symbols are used by the open source driver "video-2-1394" 
> > > ( http://sourceforge.net/projects/video-2-1394 ).
> > 
> > 
> > are you going to submit that driver for inclusion any time soon ?
> 
> What would be the benefit if I do so? 

you get a lot more eyes on the code; other people help adjusting your
code to new apis etc etc

> I have no access to linux1394 SVN or kernel repositories 
> so I can only support the version on sourceforge. 

well.. you do have access to the kernel one basically; just submit well
isolated patches to akpm/linus and they'll show up in a not-too-long
time....



