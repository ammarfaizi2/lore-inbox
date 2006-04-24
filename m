Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWDXUgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWDXUgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDXUgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:36:15 -0400
Received: from uproxy.gmail.com ([66.249.92.169]:11488 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751254AbWDXUgL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:36:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jsu9vHMcxKhienCQtMqw9lpamTRKZ69Pu6Wi5sNHtxmyG14CxGVf088zKiaGAuocSgwcCKYi2QCau9w3ytjjvAYPQV95XBySrxOLQ05S+RDRc5VJTNXUXnW2Rbgrdm9TgY/vFsyyNDcJ3nvpua6k9/RTV8oQv6zcht0hhw5qmH8=
Message-ID: <82ecf08e0604241336g73352b2r653365314f8b13a5@mail.gmail.com>
Date: Mon, 24 Apr 2006 17:36:09 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Gary Poppitz" <poppitzg@iomega.com>
Subject: Re: C++ pushback
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, let's get a couple of things clear...

No one here "hates" C++ per se. It is a tool, and every tool has its purpose.

Using C++ in the kernel has not been deemed apropriate for several
reasons. There are several (other) reasons to make the Linux Kernel C
only, this has been discussed, trolled, flamed, argued, come, gone,
etc, etc FAQs and searches are your friend there.

In your scenario, you have two possible option (IMHO)

1 - Port your existing code to C

2- keep it in C++, keep it in user level and have a simple file system
driver communicating with your existing code (I think FUSE applies to
the situation)

Thiago



On 4/24/06, Gary Poppitz <poppitzg@iomega.com> wrote:
> > We know they are "incompatible", why else would we allow "private" and
> > "struct class" in the kernel source if we some how expected it to work
> > with a C++ compiler?
>
>
> I can see that this was intentional, not an oversight.
>
> If there is a childish temper tantrum mentality about C++ then I have
> no reason or desire to be on this list.
>
> Grow up.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
