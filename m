Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317421AbSGZJWr>; Fri, 26 Jul 2002 05:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317429AbSGZJWr>; Fri, 26 Jul 2002 05:22:47 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:27380 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317421AbSGZJWq>; Fri, 26 Jul 2002 05:22:46 -0400
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>
In-Reply-To: <9143.1027671559@redhat.com>
References: <3D40A3E4.9050703@snapgear.com> 
	<3D3FA130.6020701@snapgear.com> <9309.1027608767@redhat.com>  
	<9143.1027671559@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 11:39:51 +0100
Message-Id: <1027679991.13428.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It occurs to me that this doesn't work too well without an MMU though. Got 
> any better ideas? Could we disable entire processes when one of their pages 
> is inaccessible?

It doesn't work with an MMU either. Consider O_DIRECT file writing from
such a page

