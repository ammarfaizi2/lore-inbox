Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVCJPkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVCJPkn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVCJPkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:40:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21916 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262668AbVCJPiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:38:12 -0500
Subject: Re: [patch 1/1] /proc/$$/ipaddr and per-task networking bits
From: Arjan van de Ven <arjan@infradead.org>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1110468517.9190.24.camel@localhost.localdomain>
References: <1110464202.9190.7.camel@localhost.localdomain>
	 <1110464782.6291.95.camel@laptopd505.fenrus.org>
	 <1110468517.9190.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Mar 2005 16:38:07 +0100
Message-Id: <1110469087.6291.103.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8bit
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

On Thu, 2005-03-10 at 16:28 +0100, Lorenzo Hernández García-Hierro
wrote:

> > 2) Can you explain briefly what this is useful for?
> 
> For keeping track on the "originating ip address of the
> task/process" (the ipv4 address of the user that started the
> task/process).

but.... tasks don't have an IP address. Hosts do. Hosts can have
multiple IP addresses. Both ipv4 and ipv6.  Users don't have IP
addresses either (they do have user IDs so that link is clear). 
I think I'm missing something big here. What does it *mean* for a task
to have an IP address. Once that is clear maybe I can start to
understand the rest, but until the meaning of "task has an IP address"
is better explained/more clear I think I'm stuck. (and no the output in
a log isn't a meaning, it's only a result)


