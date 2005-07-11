Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVGKLIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVGKLIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 07:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVGKLIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 07:08:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1701 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261631AbVGKLIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 07:08:13 -0400
Subject: Re: PROBLEM: fork() & setpriority()
From: Arjan van de Ven <arjan@infradead.org>
To: Rommer <rommer@active.by>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42D250C1.6070604@active.by>
References: <42D250C1.6070604@active.by>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 13:07:55 +0200
Message-Id: <1121080075.3177.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Mon, 2005-07-11 at 13:58 +0300, Rommer wrote:
> Hello,
> 
> I have trouble with fork() and setpriority().
> When priority of child process != priority of parent process
> and used SIGCHLD handler.
> See example.

the example is buggy in that printf() isn't allowed in signal handlers
btw...


