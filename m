Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVKAUqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVKAUqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVKAUqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:46:13 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:5565 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751212AbVKAUqM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:46:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MWgaLzFnBmdlXGNbvKnuMCz8b4H6qsgv/x39o4fjFxvFF0KmOui09dRCwcfGjeZ46vg084HEgDzg7w93bhnN74n6C1ZNGlDpeoPbgAaapQf+cdYlPOPkrNQhddGxBTujtdm7qwoCLsayyzwJ1Bj0NZPk+hltlhYPqnWmwdy+9fs=
Message-ID: <5449aac20511011246r6ece9f18rb3b7353dbfc2dedb@mail.gmail.com>
Date: Tue, 1 Nov 2005 20:46:11 +0000
From: Alexander Fisher <alexjfisher@gmail.com>
Reply-To: alex@alexfisher.me.uk
To: Michael Buesch <mbuesch@freenet.de>
Subject: Re: Would I be violating the GPL?
Cc: "Jeff V. Merkey" <jmerkey@utah-nac.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200511012012.32995.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
	 <200511012000.21176.mbuesch@freenet.de>
	 <4367A990.2040301@utah-nac.org>
	 <200511012012.32995.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Michael Buesch <mbuesch@freenet.de> wrote:
> On Tuesday 01 November 2005 18:44, you wrote:
> > No, don't take the code without the suppliers permission.
>
> I interpreted his text as if he already has permission to use the code.
>
> > It contains
> > trade secrets and you can get into a ot of trouble if there's an
> > agreement between the two of you.  Contact the supplier.  Tell them to
> > abstract away thre kernel headers, or rewrite to remove them, or grant
> > you persmission to open source the driver.
>
> I did not say he should open source the driver. That will give trouble.
> I suggested to write a _device_ specification. Driver specific things do not
> care.

I've got the source code to the device firmware too.  So despite the
fact the driver has been written in c++, it might be possible to write
a usable specification.  This isn't something I want to do.  I'd
imagine this sort of action can really ruin a supplier/customer
relationship.  What good is a GPLed driver if no one is prepared to
sell you the hardware?
So if the conclusion is that the driver can't be distributed under
anything other than the GPL (further opinions/confirmations welcome),
I think I've got two options.  Find a different hardware vendor or
convince the current supplier to relicense their code.
I'm hoping that the opinions from one or two major linux kernel
copyright holders will help me in convincing them to do this.

Thanks,
Alex
