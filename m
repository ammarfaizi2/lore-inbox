Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbULaRsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbULaRsD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbULaRsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:48:03 -0500
Received: from canuck.infradead.org ([205.233.218.70]:52237 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262127AbULaRrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:47:41 -0500
Subject: Re: the umount() saga for regular linux desktop users
From: Arjan van de Ven <arjan@infradead.org>
To: William <wh@designed4u.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200412311741.02864.wh@designed4u.net>
References: <200412311741.02864.wh@designed4u.net>
Content-Type: text/plain
Date: Fri, 31 Dec 2004 18:47:33 +0100
Message-Id: <1104515254.5402.35.camel@laptopd505.fenrus.org>
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

On Fri, 2004-12-31 at 17:41 +0000, William wrote:
> Hi
> 
> I am a linux desktop user. I love linux and all the wonderfull 
> open-source/free software that comes with it... blah, blah, blah :). The 
> following comments and suggestions about umount() stem from personal 
> experience and are meant as friendly feedback for all you clever people. (I 
> wish I understook how the kernel works)
> 
> Regularly, when attempting to umount() a filesystem I receive 'device is busy' 
> errors. The only way (that I have found) to solve these problems is to go on 
> a journey into processland and kill all the guilty ones that have tied 
> themselves to the filesystem concerned.
> 
> In order to help solve this problem is it possible to modify the behaviour of 
> the linux kernel.


what you describe is almost like lazy umounting.. which I think comes
quite close...


