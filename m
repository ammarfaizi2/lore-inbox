Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVCJQLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVCJQLk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVCJQLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:11:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63644 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262680AbVCJQJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:09:00 -0500
Subject: Re: [patch 1/1] /proc/$$/ipaddr and per-task networking bits
From: Arjan van de Ven <arjan@infradead.org>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1110470430.9190.33.camel@localhost.localdomain>
References: <1110464202.9190.7.camel@localhost.localdomain>
	 <1110464782.6291.95.camel@laptopd505.fenrus.org>
	 <1110468517.9190.24.camel@localhost.localdomain>
	 <1110469087.6291.103.camel@laptopd505.fenrus.org>
	 <1110470430.9190.33.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Mar 2005 17:08:55 +0100
Message-Id: <1110470935.6291.105.camel@laptopd505.fenrus.org>
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

On Thu, 2005-03-10 at 17:00 +0100, Lorenzo Hernández García-Hierro
wrote: it tries to fill the
> ipaddr member of the task_struct structure with the IP address
> associated to the user running @current task/process,if available.

but... a use doesn't hane an IP. a host does.


