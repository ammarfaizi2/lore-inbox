Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVBYPgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVBYPgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVBYPgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:36:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62387 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262721AbVBYPgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:36:36 -0500
Subject: Re: Invalid module format in Fedora core2
From: Arjan van de Ven <arjan@infradead.org>
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0502252056130.17145@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0502252056130.17145@lantana.cs.iitm.ernet.in>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 16:36:29 +0100
Message-Id: <1109345789.6290.74.camel@laptopd505.fenrus.org>
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

On Fri, 2005-02-25 at 20:57 +0530, Payasam Manohar wrote:
>   Hai all,
>    I tried to insert a sample module into Fedora core 2 , But it is giving 
> an error message that " no module in the object"
> The same module was inserted successfully into Redhat linux 9.
> 
> Is there any changes from RH 9 to Fedora Core 2 with respect to the module 
> writing and insertion.

yes; 2.6 has a new module system. It sounds like you're not building
your module correctly, look in the Documentation/ directory for more
information on how to build modules for 2.6 kernels



