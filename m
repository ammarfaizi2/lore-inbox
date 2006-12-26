Return-Path: <linux-kernel-owner+w=401wt.eu-S932582AbWLZNfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWLZNfe (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 08:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWLZNfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 08:35:34 -0500
Received: from smtp108.rog.mail.re2.yahoo.com ([68.142.225.206]:23512 "HELO
	smtp108.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932582AbWLZNfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 08:35:33 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 08:35:33 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:X-YMail-OSG:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=spRk8FV5C+wBX5XlmqdmKO3P0ymkTgiO3i1uibiLt+xpt3APCDRz8uEXPSJPUCMwhrE7LUxTFdlZy2Wz7FMYkIPGBkM6MIki7OPLA3JcAgmWT6xcDz8h1PoxyMVB8Twef5iQxj87SmaqMPRtxbyMQeyJYj7YyeW3aKvbe813QdQ=  ;
X-YMail-OSG: pT2L1YIVM1mxeGA_PdNRHkkwJvMQxOuMx2osQ5E5IVIRat7UZe5wUEbQjR29q6QT0C4BotKJHoRhWBJnX5xDgc1SHayRGFoNr1rWrOjIDBbnL3QsDYmpeTFTydqClM0fObmxOa8J6JviNh0jG9r9Ahgm0r1iOE64FM00AsO2IPmBKqcKjAG7be1up7FU
Subject: Re: Binary Drivers
From: James C Georgas <jgeorgas@rogers.com>
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061226112040.95091.qmail@web32614.mail.mud.yahoo.com>
References: <20061226112040.95091.qmail@web32614.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 26 Dec 2006 08:28:52 -0500
Message-Id: <1167139732.15424.48.camel@Rainsong>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-26-12 at 03:20 -0800, Martin Knoblauch wrote:
> On 12/25/06, David Schwartz <davids@xxxxxxxxxxxxx> wrote:
> 
> >   If I bought the car from the manufacturer, it also must
> > include any rights the manufacturer might have to the car's use.
> > That includes using the car to violate emission control measures.
> > If I didn't buy the right to use the car that way (insofar as
> > that right was owned by the car manufacturer), I didn't
> > buy the whole care -- just *some* of the rights to use it.
> 
>  just to be dense - what makes you think that the car manufacturer has
> any legal right to violate emission control measures? What an utter
> nonsense (sorry).
> 
>  So, lets stop the stupid car comparisons. They are no being funny any
> more.

Let's summarize the current situation:

1) Hardware vendors don't have to tell us how to program their products,
as long as they provide some way to use it (i.e. binary blob driver).

2) Hardware vendors don't want to tell us how to program their products,
because they think this information is their secret sauce (or maybe
their competitor's secret sauce).

3) Hardware vendors don't tell us how to program their products, because
they know about (1) and they believe (2).



4) We need products with datasheets because of our development model.

5) We want products with capabilities that these vendors advertise.

6) Products that satisfy both (4) and (5) are often scarce or
non-existent.


So far, the suggestions I've seen to resolve the above conflict fall
into three categories:

a) Force vendors to provide datasheets. 

b) Entice vendors to provide datasheets.

c) Reverse engineer the hardware and write our own datasheets.

Solution (a) involves denial of point (1), mostly through the use of
analogy and allegory. Alternatively, one can try to change the law
through government channels.

Solution (b) requires market pressure, charity, or visionary management.
We can't exert enough market pressure currently to make much difference.
Charity sometimes gives us datasheets for old hardware. Visionary
management is the future.

Solution (c) is what we do now, with varying degrees of success. A good
example is the R300 support in the radeon DRM module.

Did I miss anything?

