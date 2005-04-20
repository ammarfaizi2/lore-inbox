Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVDTJTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVDTJTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 05:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVDTJTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 05:19:11 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:4697 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261522AbVDTJTH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 05:19:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C/4YSPx63+Gz69S53wzTwRDq7LGtbjrUk6ACuR8ucmVoas4zlXVefGQGBS0IYu87c+QcNlHO9dj0tHXufg+UaUGyAroUjLAdv8HwktsmrlNF8HD9JtHSlosYI+5yor6Yo8MsL6WXzZcox5WLRbFzlP5fpa9eyduGvdFL7SSQEuc=
Message-ID: <28183df505042002186e5c3d49@mail.gmail.com>
Date: Wed, 20 Apr 2005 12:18:43 +0300
From: Zvi Rackover <zvirack@gmail.com>
Reply-To: Zvi Rackover <zvirack@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Module that loads new Interrupt Descriptor Table
In-Reply-To: <1113987941.6238.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <28183df5050420015828ace752@mail.gmail.com>
	 <1113987941.6238.52.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2005-04-20 at 11:58 +0300, Zvi Rackover wrote:
> > Hello all,
> >
> >   I would like to write a program that monitors various system
> > parameters in real time. One of these is counting the number of
> > interrupts. I would like to implement my own interrupt handler so that
> > each handler counts the number of interrupt of its respective type.
> 
> ehm
> the kernel already keeps this kind of data, see /proc/interrupts
> 
> why would you want to collect it *again* ?
> (or do you want to generally hook interrupts like some other people want
> to hook syscalls?)
> 
> 
You have a good point point - I should have given a better decription
to my problem.
This is an educational project I'm working on and I need to actually
see the contents of the Interrupt Descritor Table so I could load it
into user space and have it displayed in a nice GUI.
