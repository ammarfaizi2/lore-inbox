Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVKVDBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVKVDBO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVKVDBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:01:14 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:2234 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964883AbVKVDBN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:01:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KJSGjkARVeJxRT49X521fe1/5kfKO2Rg6KYEwr4RdTXZnGiUMMES5+ybHC22IyexNVWabGUVW17+2u+ne8Ekg61QQudRI6rbmlc1exfgi0glp08dbij4Fwf+UtcHMusmt478SqksjKkLQTyXhiIb9Z/heDKVK6VxJY4Hd6kdfeE=
Message-ID: <9e4733910511211901s6785788dh37177b684ab1418f@mail.gmail.com>
Date: Mon, 21 Nov 2005 22:01:13 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Small PCI core patch
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1132626973.26560.114.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
	 <9e4733910511211820x3539213arfe20f3939a375b51@mail.gmail.com>
	 <1132626973.26560.114.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> But the real reasons are elsewhere anyway. They don't wnat to opensource
> because they don't want to open the gazillion security holes in their
> stuff (afaik, the binary drivers make absolutely no verification of the
> command streams passed from userland, you can make the card do whatever
> you want from any user context, including arbitrary DMA to/from system
> memory), the various comments & workarounds for HW bugs that aren't
> supposed to exist and might make some customers want to throw the cards
> back at them, the disgusting pile of smelly windows-originated library
> they link in and wrap all over the place to make linux look like NT,
> etc...

Build some root exploits using their drivers and start sending them to
LKML. The resulting bad PR should fix their security holes quick
enough. Who knows, maybe the heat will be hot enough for them to go
open source.

--
Jon Smirl
jonsmirl@gmail.com
