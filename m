Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132626AbRC2APh>; Wed, 28 Mar 2001 19:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132663AbRC2APb>; Wed, 28 Mar 2001 19:15:31 -0500
Received: from [24.93.35.223] ([24.93.35.223]:11457 "EHLO texlog2.texas.rr.com")
	by vger.kernel.org with ESMTP id <S132626AbRC2APM>;
	Wed, 28 Mar 2001 19:15:12 -0500
Message-ID: <003101c0b7e5$0c53dbb0$0201a8c0@mojo>
From: "Paul Fulghum" <paulkf@microgate.com>
To: <linux-kernel@vger.kernel.org>,
   "Krzysztof Halasa" <khc@intrepid.pm.waw.pl>
Cc: "Francois Romieu" <romieu@cogenit.fr>
In-Reply-To: <m3itkuq6xt.fsf@intrepid.pm.waw.pl><20010328182729.A16067@se1.cogenit.fr> <m34rwd8pj2.fsf@intrepid.pm.waw.pl>
Subject: Re: RFC: configuring net interfaces
Date: Wed, 28 Mar 2001 18:13:10 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Krzysztof Halasa" <khc@intrepid.pm.waw.pl>

 > +struct hdlc_physical /* 10 bytes */
> +{
> + unsigned int interface;
> + unsigned int clock_rate;
> + unsigned short clock_type;
> +};

What about encoding (NRZ/NRZI)?

Plus I think the CRC type would be a good idea for
raw HDLC mode. (CRC-16, CRC-32, no CRC)

Paul Fulghum
paulkf@microgate.com

