Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbUKKWNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbUKKWNr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUKKVtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:49:07 -0500
Received: from canuck.infradead.org ([205.233.218.70]:14607 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262372AbUKKVsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:48:18 -0500
Subject: Re: module tool with 2.6.9 issue
From: Arjan van de Ven <arjan@infradead.org>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <08A354A3A9CCA24F9EE9BE13600CFBC50F85CE@wcosmb07.cos.agilent.com>
References: <08A354A3A9CCA24F9EE9BE13600CFBC50F85CE@wcosmb07.cos.agilent.com>
Content-Type: text/plain
Message-Id: <1100209690.6760.2.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 11 Nov 2004 22:48:10 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 14:27 -0700, yiding_wang@agilent.com wrote:
> I am using moudle-init-tools-3.1-pre6 with kernel 2.6.9. The new insmod seems have restrictions which failed using parameters to load a driver module.
> 
> My module parameter is in the form of modname="*************** ****", a quite long one.
> Run - insmod modname.o modname="*********** *******" (with a script), it complains about the space and treats the string next to the space to be a "Unknown parameter".
> 
> By replacing the space with any character, then it complains 
> "modname: string parameter too long"


can you post an url to the sourcecode... it's going to be really had for ANYONE to dive into this without that

