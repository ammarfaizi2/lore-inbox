Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269194AbTCBMLb>; Sun, 2 Mar 2003 07:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269196AbTCBMLb>; Sun, 2 Mar 2003 07:11:31 -0500
Received: from AMarseille-201-1-3-35.abo.wanadoo.fr ([193.253.250.35]:16424
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S269194AbTCBMLa>; Sun, 2 Mar 2003 07:11:30 -0500
Subject: Re: 2.5.63: 'Debug: sleeping function called from illegal context
	at mm/slab.c:1617'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1046598825.2030.101.camel@zion.wanadoo.fr>
References: <20030301210518.GA740@gallifrey>
	 <1046568414.24557.11.camel@irongate.swansea.linux.org.uk>
	 <1046598825.2030.101.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046607762.2019.107.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 02 Mar 2003 13:22:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well... it's a bug in _all_ archs. They (almost) all call the proc
> stuff from request_irq, and worse, on x86, I think, has the
> kmalloc inside request_irq changed to GFP_ATOMIC.

I meant "Only" x86 does GFP_ATOMIC

Ben.

