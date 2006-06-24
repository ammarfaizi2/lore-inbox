Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWFXQsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWFXQsx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 12:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWFXQsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 12:48:53 -0400
Received: from gw.goop.org ([64.81.55.164]:50583 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750876AbWFXQsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 12:48:53 -0400
Message-ID: <449D6D07.9070901@goop.org>
Date: Sat, 24 Jun 2006 09:49:11 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] ext3_clear_inode(): avoid kfree(NULL)
References: <200606231502.k5NF2jfO007109@hera.kernel.org>	 <449C3817.2030802@garzik.org> <20060623142430.333dd666.akpm@osdl.org>	 <1151151104.3181.30.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.58.0606240817170.23087@gandalf.stny.rr.com>	 <1151152059.3181.37.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.58.0606240833010.23318@gandalf.stny.rr.com> <1151153177.3181.39.camel@laptopd505.fenrus.org>
In-Reply-To: <1151153177.3181.39.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> nope none at all, at least not on x86/x86-64.
> (in fact there is no way to help the prediction on those architectures
> that actually works)
>   
The branch prediction hint prefixes (2e & 3e) don't work?

    J
