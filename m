Return-Path: <linux-kernel-owner+w=401wt.eu-S1422770AbWLUGpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbWLUGpZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422769AbWLUGpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:45:25 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:20189 "HELO
	smtp102.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422770AbWLUGpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:45:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=JbjhxymPprpq5qIERLAyAN7RMHGT7ryFsFzCTYgTxFCLD3IiQdfJlln46g33TL0NvtcvvqEu+A+a7Icsc21VtZXeFU7rmpTW4mSzPh5c8yq3eCHFOyKpOhZtdMTuD6eo4eVPDNIWugGAJaJVe4YdXUIe2NPA40lkSBpMZtQ6NKE=  ;
X-YMail-OSG: R4zATj0VM1kAK1tS2.91bt.iVEL6HOoyYXHY6FJvuYvE3WjoFxId_2jt26XNDBUMVqNUYsbb2E8niQwZXU1TgB.T4PUOmDtuW0a6ByAzUV2WGNICTtdYiQ--
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.20-rc1 3/6] AT91 GPIO wrappers
Date: Wed, 20 Dec 2006 22:45:20 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net> <200612201311.20517.david-b@pacbell.net> <20061220221032.2f30dd72.akpm@osdl.org>
In-Reply-To: <20061220221032.2f30dd72.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612202245.21524.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 December 2006 10:10 pm, Andrew Morton wrote:
> On Wed, 20 Dec 2006 13:11:19 -0800
> David Brownell <david-b@pacbell.net> wrote:
> 
> > +static inline int gpio_get_value(unsigned gpio)
> > +	{ return at91_get_gpio_value(gpio); }
> > +
> > +static inline void gpio_set_value(unsigned gpio, int value)
> > +	{ (void) at91_set_gpio_value(gpio, value); }
> 
> whaa?  Where'd we pull that coding style from?

School of concision.  Notice also the clever ";) at the end of each line.


> Please,

I see you fixed this in what you merged to MM; thanks.

- Dave


> static inline int gpio_get_value(unsigned gpio)
> {
> 	return at91_get_gpio_value(gpio);
> }
> 
> static inline void gpio_set_value(unsigned gpio, int value)
> {
> 	at91_set_gpio_value(gpio, value);
> }
> 
