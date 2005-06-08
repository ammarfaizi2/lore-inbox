Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVFHO3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVFHO3C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVFHO3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:29:02 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:31387
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261254AbVFHO26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:28:58 -0400
Subject: Re: [PATCH -RT] Softirq splitting
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: YOSHIFUJI Hideaki / =?UTF-8?Q?=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20050608.231531.126041907.yoshfuji@linux-ipv6.org>
References: <1118239409.20785.628.camel@tglx.tec.linutronix.de>
	 <20050608.231531.126041907.yoshfuji@linux-ipv6.org>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 08 Jun 2005 16:29:41 +0200
Message-Id: <1118240981.20785.632.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	TASKLET_SOFTIRQ
> > +	/* Entries after this are ignored in the split softirq mode */
> > +	MAX_SOFTIRQ,
> >  };
> >  
> 
> Hey, have you ever compiled?
> You need comma after TASKLET_SOFTIRQ.

Sorry, your right. I missed that when I extracted it from my devel tree.

tglx


