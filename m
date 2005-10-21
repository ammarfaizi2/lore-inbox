Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVJUOD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVJUOD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVJUOD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:03:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13194 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964958AbVJUOD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:03:26 -0400
Subject: Re: Understanding Linux addr space, malloc, and heap
From: Arjan van de Ven <arjan@infradead.org>
To: "Vincent W. Freeh" <vin@csc.ncsu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4358F0E3.6050405@csc.ncsu.edu>
References: <4358F0E3.6050405@csc.ncsu.edu>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 16:03:16 +0200
Message-Id: <1129903396.2786.19.camel@laptopd505.fenrus.org>
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

On Fri, 2005-10-21 at 09:45 -0400, Vincent W. Freeh wrote:
> Thanks for your quick response.  It basically confirmed that I observed 
> what I thought I did.  However, I am no closer to solving my problem.  I 
> cannot mprotect data that I malloc beyond the first 65 pages.

you can't mprotect malloc() memory period ..
>   Why is 
> that?  Can that be fixed?  Second, why does mprotect silently fail?  I 
> could live with it failing--but I cannot deal with a call the "works" 
> but doesn't work.

need more info :)

