Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbULXJLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbULXJLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 04:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbULXJLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 04:11:17 -0500
Received: from canuck.infradead.org ([205.233.218.70]:45838 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261278AbULXJLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 04:11:15 -0500
Subject: Re: Re : Re: Intercepting system calls in Linux kernel 2.6.x
From: Arjan van de Ven <arjan@infradead.org>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20041224060906.21085.qmail@web60606.mail.yahoo.com>
References: <20041224060906.21085.qmail@web60606.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 24 Dec 2004 10:11:03 +0100
Message-Id: <1103879463.4131.11.camel@laptopd505.fenrus.org>
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

On Thu, 2004-12-23 at 22:09 -0800, selvakumar nagendran wrote:
> Hello,
>      I want to save the system call parameters in a
> table. I want to do this from the kernel module. For
> that, I want to replace the already existing system
> call handler by my own. Are there any other mechanisms
> for doing this without exporting system call table? If
> it is then plz suggest any one of them?

ewww

if you do this for auditing purposes... who not use the auditing
subsystem that is already there ?

