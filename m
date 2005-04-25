Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVDYQbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVDYQbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVDYQaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:30:55 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:31445 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262667AbVDYQaT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:30:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pOf6Rvsj8uecD3Hdx1aVNK2RXaV4cOwkR/ncXnPNVXAztJ/ji7I7EYPDzyR/V3LeXVGMKXZnq/uLXbs7CYX7cUHCzjx0X5RILiniyQ3Ct+vCituX2HyNhCFMUQ+odRplpli+vugZdjUg3jXiHkOvMaWt8cORwtVFRho9N/NavPw=
Message-ID: <5fc59ff3050425093012ab23b2@mail.gmail.com>
Date: Mon, 25 Apr 2005 09:30:12 -0700
From: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Reply-To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Subject: Re: Linux kernel TI TLAN driver
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Atro.Tossavainen@helsinki.fi,
       torben.mathiasen@compaq.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050425135603.GD7617@linux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504220800.j3M80GSL006528@kruuna.helsinki.fi>
	 <1114428275.18355.7.camel@localhost.localdomain>
	 <20050425135603.GD7617@linux2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In general, just adding the device id to a driver in order to enable
it for a new device is not sufficient. They may (in most cases, will)
be additional logic that is needed in the driver to correctly enable
the  new device. If this is the case, I'd expect the patched driver to
fail on open even with the 2.6 kernel.

ganesh.

On 4/25/05, Torben Mathiasen <torben.mathiasen@hp.com> wrote:
> On Mon, Apr 25 2005, Alan Cox wrote:
> > Try with 2.6.x - I'm not sure the 64bit cleanness stuff ever all got
> > into the 2.4 driver version.
> 
> Yeah the 2.6 version is your best bet. Allthough, I haven't tried it on an
> Alpha in a long time.
> 
> BTW. I'm not maintaining the driver anymore. Samuel Chessman (chessman@tux.org)
> took over maintainership, but I'm not sure if he's still active.
> 
> Torben
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
