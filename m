Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWGGFta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWGGFta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 01:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWGGFta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 01:49:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49386 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750914AbWGGFta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 01:49:30 -0400
Subject: Re: Module link
From: Arjan van de Ven <arjan@infradead.org>
To: yh@bizmail.com.au
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2513.203.217.29.133.1152250423.squirrel@203.217.29.133>
References: <3306.58.105.227.226.1152244539.squirrel@58.105.227.226>
	 <20060706210805.b9e952ca.rdunlap@xenotime.net>
	 <2513.203.217.29.133.1152250423.squirrel@203.217.29.133>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 07:49:26 +0200
Message-Id: <1152251366.3111.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 15:33 +1000, yh@bizmail.com.au wrote:
> Thanks Randy. Let me clarify it.
> 
> I have a driver module (NewSerialModule.ko) and I build it for module
> load. This driver module uses i2c functions. It was fine to init this
> module in kernel 2.4 as the i2c functions are exported in i2c Makefile.
> 
> In kernel 2.6, I loaded this module and got NULL point exception. 

you very likely have a bug in your code or in your Makefile. Since you
haven't posted either.. how are we supposed to help you? Please provide
a URL to both the source and the Makefile.


