Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVAKHjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVAKHjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 02:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVAKHjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 02:39:18 -0500
Received: from canuck.infradead.org ([205.233.218.70]:23302 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262472AbVAKHjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 02:39:14 -0500
Subject: Re: [PATCH 0/6] 2.4.19-rc1 stack reduction patches
From: Arjan van de Ven <arjan@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 08:39:03 +0100
Message-Id: <1105429144.3917.0.camel@laptopd505.fenrus.org>
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

On Mon, 2005-01-10 at 09:35 -0800, Badari Pulavarty wrote:
> Hi Marcelo,
> 
> I re-worked all the applicable stack reduction patches for 2.4.19-rc1.


is it really worth doing this sort of thing for 2.4 still? It's a matter
of risk versus gain... not sure this sort of thing is still worth it in
the deep-maintenance 2.4 tree

