Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVLHJmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVLHJmM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 04:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVLHJmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 04:42:12 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:45319 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750993AbVLHJmM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 04:42:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cu+VA4kXQACQpqvpWuzAyOOPsDBAUDbUvWUEOEVzvIfbjTrl0tTg8MdzdDLkkdtK6I+0UzHJr5B7OLA3S1anl/itKFYvJ6iP7OtDn5n8YyQBZJwwdDZaygQeumrnJbv74IXollUPoRo4ROKj2thy4NIDf8xPC5eDorOaSW0um0E=
Message-ID: <5a2cf1f60512080142j175bc79eq1b95182d22268b6b@mail.gmail.com>
Date: Thu, 8 Dec 2005 10:42:11 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Runs with Linux (tm)
Cc: Dirk Steuwer <dirk@steuwer.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20051207141720.GA533@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random>
	 <43944F42.2070207@didntduck.org>
	 <loom.20051206T094816-40@post.gmane.org>
	 <20051206104652.GB3354@favonius>
	 <loom.20051206T173458-358@post.gmane.org>
	 <20051207141720.GA533@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Benjamin LaHaise <bcrl@kvack.org> wrote:
> On Tue, Dec 06, 2005 at 04:41:44PM +0000, Dirk Steuwer wrote:
> > Yes, but there isn't and won't be much recognition - every company does
> > its own thing. And how many people buy online all the time? But even then,
> > a genery "runs with Linux" Logo would be great. If a company's product
> > is not certified, its not considered by Linux customers.
>
> This is something I've wanted to see for years now.  Linux distributions
> do not have the motivation to work out the hardware certification issues
> on the community level, as it interferes with their value add of branding.
> I have always wished that when I see hardware advertising Linux support
> that it has a meaning: open source, supportable drivers.  Maybe it's time
> to get such a project moving.

I've read that thread with interest and would like to share some of my thoughts.

What are the issues with a "run with Linux" sticker?

- supported by who? kernel.org? a distribution? the vendor?

- accredited by who? the entity that supports? an external entity?

- support which features? If the in-kernel driver contains the bare
minimum number of features, but no support for the advanced features,
what does the support claim mean? E.g. with all the OSS/ALSA, APM/ACPI
debates, I wonder what happens whenever a hardware is 'half'
supported.

- which Linux version? Some people mention restricting support to a
particular linux version or time periods. I find this not very
practical. How can you guarantee that in the next 2 years (or even 6
months)? With non stable API/ABI, how do you want to sell the idea of
unknown unforecastable development costs to the hardware maker?

- I still see people saying supported on "Linux 9.1" (aka Red Hat/Suse
or whatever)...

- it requires the manufacturer to care about putting the sticker in
place. If they start to advertise support, they will have more costs,
even if the support is handled by an external entity.

- what happens when a different revision of the 'same' hardware is not
supported anymore? It happened with one my webcam.

- how does that work when online? You will have a particular hardware
saying "Runs With Linux" and another one fully supported by the maker,
or fully unsupported use-ndiswrapper-like saying "Runs On Linux" or
"Works on Linux". How does the sticker help me to decide?


Because of all these reasons, I don't think we will ever have half of
the really supported hardware even display the sticker. What does that
mean for me as a user? I will still need to search for information
about the other part.

How to identify the other part?

I'd rather want to know this information from the community. The
community, in help with the distribution vendors, should come up with
a big database that contains all this information. I don't want to go
on the ALSA web site to check if my sound card is supported, then on
the SATA one for my disk controller, then on linux-usb etc...

I want tools to help us feed that database, like the Ubuntu Device
Database client. But I want that at the Linux scale not the
distribution one.
* The client software would be used to report functional state of
hardware elements or access information about a particular hardware
present on the machine.
* There should be an easy way to have a Live distro with the latest
kernel that contains the minimal set of programs required to run this
Hardware Database client.

Cheers,

Jerome
