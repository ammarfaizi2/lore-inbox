Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVAGPYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVAGPYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVAGPYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:24:10 -0500
Received: from canuck.infradead.org ([205.233.218.70]:38405 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261454AbVAGPYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:24:06 -0500
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
From: Arjan van de Ven <arjan@infradead.org>
To: paulmck@us.ibm.com
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com
In-Reply-To: <20050107151223.GA1267@us.ibm.com>
References: <20050106190538.GB1618@us.ibm.com>
	 <1105039259.4468.9.camel@laptopd505.fenrus.org>
	 <20050106201531.GJ1292@us.ibm.com>
	 <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106210408.GM1292@us.ibm.com>
	 <1105083213.4179.1.camel@laptopd505.fenrus.org>
	 <20050107151223.GA1267@us.ibm.com>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 16:23:52 +0100
Message-Id: <1105111432.4179.31.camel@laptopd505.fenrus.org>
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


> > eh maybe a weird question, but why are you and not the MVFS guys asking
> > for this export then? They can probably better explain why they need
> > it ....
> 
> As near as I can tell, they believe that they already did the best they
> could to explain their needs and failed to do so.
> 

can you try to find even ONE request for these exports from them in the
mailing list archives? Since I find that hard to believe.

