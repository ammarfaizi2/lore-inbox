Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVK1LA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVK1LA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 06:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVK1LA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 06:00:57 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:49819 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932071AbVK1LA4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 06:00:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JDAh6N1Nojn/+EKyIdatrbs6JHwnzEAiDeYqbNFKfDb7+rDlF3lD09uTU+ssqQt37wHdmvbVFeo6LgSZgsjDUCgYswfIBA7ioXo+G6StLTPepNwkiVfsllLn/vpkCEVyVcOv3MBAEtU9IGIeiBNqy4xNze3rmObC7Ww/YalHrik=
Message-ID: <6880bed30511280300g6aa05e64of3e5444d117401fb@mail.gmail.com>
Date: Mon, 28 Nov 2005 12:00:56 +0100
From: Bas Westerbaan <bas.westerbaan@gmail.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: user mounting
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0511272306270.19403@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511272148.jARLmdn08633@apps.cwi.nl>
	 <Pine.LNX.4.63.0511272306270.19403@gockel.physik3.uni-rostock.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can't rate limit a panic.

It would be better to fix the filesytem bugs instead of adding
security measures preventing crashing filesystems to crash the rest of
the kernel.

And to catch every possible crash of filesystem code would be a lot
more work than fixing the filesystems themselves AFAIK.

Regards,

Bas

On 11/27/05, Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> On Sun, 27 Nov 2005, Andries.Brouwer@cwi.nl wrote:
>
> > Part of my proposal for a solution lives in kernel space.
> > Introduce a mount flag "user mounted". When it is set,
> > the kernel will not do a printk() for this filesystem,
>
> Rate limiting seems like a better solution to me.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Bas Westerbaan
http://blog.w-nz.com/
GPG Public Keys: http://w-nz.com/keys/bas.westerbaan.asc
