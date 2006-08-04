Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWHDPcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWHDPcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWHDPcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:32:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47268 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932603AbWHDPcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:32:17 -0400
Subject: Re: [RFC][PATCH] A generic boolean
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jes Sorensen <jes@sgi.com>
Cc: Jeff Garzik <jeff@garzik.org>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44D35B25.9090004@sgi.com>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	 <44BE9E78.3010409@garzik.org>  <yq0lkq4vbs3.fsf@jaguar.mkp.net>
	 <1154702572.23655.226.camel@localhost.localdomain>
	 <44D35B25.9090004@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Aug 2006 16:51:26 +0100
Message-Id: <1154706687.23655.234.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-04 am 16:35 +0200, ysgrifennodd Jes Sorensen:
> The proposed patch makes it u1 - if we end up with arch specific
> defines, as the patch is proposing, developers won't know for sure what
> the size is and will get alignment wrong. That is not fine.

The _Bool type is up to gcc implementation details.

> If we really have to introduce a bool type, at least it has to be the
> same size on all 32 bit archs and the same size on all 64 bit archs.

You don't use bool for talking to hardware, you use it for the most
efficient compiler behaviour when working with true/false values.

Alan

