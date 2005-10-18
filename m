Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbVJRHxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbVJRHxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVJRHxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:53:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62905 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751460AbVJRHxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:53:48 -0400
Subject: Re: [PATCH] disable PREEMPT_BKL per default
From: Arjan van de Ven <arjan@infradead.org>
To: Olaf Hering <olh@suse.de>
Cc: mingo@elte.hu, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051018074511.GA13182@suse.de>
References: <20051016154108.25735ee3.akpm@osdl.org>
	 <20051018074511.GA13182@suse.de>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 09:53:30 +0200
Message-Id: <1129622010.2779.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 09:45 +0200, Olaf Hering wrote:
> Do not enable this per default during make oldconfig.
> 'default $foo' should not be abused like that.

afaik that was done to increase testing.
This thing shouldn't be a config option at all in a final release imo;
the config option as I understand it is there to be able to disable it
during the testing phase in -mm to help diagnose otherwise unexplained
issues.

Maybe by now it's time to remove the config option..


