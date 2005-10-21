Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVJUT6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVJUT6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 15:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbVJUT6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 15:58:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9949 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965138AbVJUT6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 15:58:40 -0400
Subject: Re: Merging ATA passthru
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43593E0A.4070801@pobox.com>
References: <43593E0A.4070801@pobox.com>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 21:58:33 +0200
Message-Id: <1129924714.2786.38.camel@laptopd505.fenrus.org>
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

On Fri, 2005-10-21 at 15:14 -0400, Jeff Garzik wrote:
> Folks,
> 
> Taking Mark Lord's (and others) criticism to heart, I'm going to merge 
> the ATA passthru work upstream, once 2.6.14 is released.
> 
> Since there are still some reported problems that I haven't had time to 
> track down, I'm going to -- like ATAPI -- introduce a module option that 
> enables passthru.  It will default to off.
> 
> Other features that follow a similar pattern -- 98% there but needs a 
> few final tweaks -- will be treated in the same way.

can you get a patch into -mm that default-on's them? That way the brave
of heart get it automatic while those who play safe get them
default-off. Expands your testingbase as well ;)


