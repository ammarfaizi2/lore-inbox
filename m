Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132719AbRC2Lny>; Thu, 29 Mar 2001 06:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132718AbRC2Lnp>; Thu, 29 Mar 2001 06:43:45 -0500
Received: from zeus.kernel.org ([209.10.41.242]:224 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132720AbRC2Ln1>;
	Thu, 29 Mar 2001 06:43:27 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <m3itkuq6xt.fsf@intrepid.pm.waw.pl>
	<20010328182729.A16067@se1.cogenit.fr>
	<m34rwd8pj2.fsf@intrepid.pm.waw.pl>
	<003101c0b7e5$0c53dbb0$0201a8c0@mojo>
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 29 Mar 2001 12:34:39 +0200
In-Reply-To: "Paul Fulghum"'s message of "Wed, 28 Mar 2001 18:13:10 -0600"
Message-ID: <m37l187tj4.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul Fulghum" <paulkf@microgate.com> writes:

>  > +struct hdlc_physical /* 10 bytes */
> > +{
> > + unsigned int interface;
> > + unsigned int clock_rate;
> > + unsigned short clock_type;
> > +};
> 
> What about encoding (NRZ/NRZI)?
> 
> Plus I think the CRC type would be a good idea for
> raw HDLC mode. (CRC-16, CRC-32, no CRC)

Here - I think so. + good defaults.
-- 
Krzysztof Halasa
Network Administrator
