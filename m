Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161279AbWHDQM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161279AbWHDQM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161280AbWHDQM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:12:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51115 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161279AbWHDQM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:12:27 -0400
Subject: Re: [RFC][PATCH] A generic boolean
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jes Sorensen <jes@sgi.com>
Cc: Jeff Garzik <jeff@garzik.org>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44D36E8B.4040705@sgi.com>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	 <44BE9E78.3010409@garzik.org>  <yq0lkq4vbs3.fsf@jaguar.mkp.net>
	 <1154702572.23655.226.camel@localhost.localdomain>
	 <44D35B25.9090004@sgi.com>
	 <1154706687.23655.234.camel@localhost.localdomain>
	 <44D36E8B.4040705@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Aug 2006 17:30:24 +0100
Message-Id: <1154709025.23655.246.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-04 am 17:58 +0200, ysgrifennodd Jes Sorensen:
> > You don't use bool for talking to hardware, you use it for the most
> > efficient compiler behaviour when working with true/false values.
> 
> Thats the problem, people will start putting them into structs, and
> voila all alignment predictability has gone out the window.

Jes, try reading as well as writing. Given you even quoted "You don't
use bool for talking to hardware" maybe you should read it.

Structure alignment is generally a bad idea anyway because even array
and word alignment are pretty variable between processors.


