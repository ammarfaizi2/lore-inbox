Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136182AbRECH5J>; Thu, 3 May 2001 03:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136186AbRECH44>; Thu, 3 May 2001 03:56:56 -0400
Received: from zeus.kernel.org ([209.10.41.242]:31652 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136182AbRECH4h>;
	Thu, 3 May 2001 03:56:37 -0400
Message-ID: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDCC@aeoexc1.aeo.cpqcorp.net>
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@compaq.com>
To: "'Bogdan Costescu'" <bogdan.costescu@iwr.uni-heidelberg.de>
Cc: "'andrewm@uow.edu.au'" <andrewm@uow.edu.au>,
        "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [3com905b freeze Alpha SMP 2.4.2] FullDuplex issue ?
Date: Thu, 3 May 2001 09:28:35 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Bogdan Costescu [mailto:bogdan.costescu@iwr.uni-heidelberg.de]
> Sent: mercredi 2 mai 2001 17:14
> To: Cabaniols, Sebastien
> Cc: 'andrewm@uow.edu.au'; 'netdev@oss.sgi.com';
> 'linux-kernel@vger.kernel.org'
> Subject: Re: [3com905b freeze Alpha SMP 2.4.2] FullDuplex issue ?
> 
> 
> On Wed, 2 May 2001, Cabaniols, Sebastien wrote:
> 
> > I insert the 3c59x module with debug=7.
> 
> Why ? debug=7 is the highest debug level and produces _lots_ 
> of debug data
> for high network activity. Do you have problems when 
> insmod-ing without
> any option and use a higher debug level just to see what's going on?

It is only to produce verbose logs. (See attached file in original email)


> 
> > The first of the above machines launching the get freezes.
> 
> Why do you believe that the card/driver is responsible for 
> the freeze ?

Excellent question: I don't know, should I suspect the wu-ftpd daemon ?
Since the machine is crashed I guess I can suspect some code doing
system stuff, drivers/kernel or daemons ?


> The outputs that you provided show no problems to me.
> 
> A duplex mismatch would not freeze a computer. You would get crappy
> transfer rates, usually some error messages from the driver, but
> everything should otherwise work. To verify the media 
> settings, you might
> want to use mii-diag (from ftp.scyld.com).

Ok, let me see how we compile this and send you the output.


> 
> Sincerely,
> 
> Bogdan Costescu
> 
> IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
> Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
> Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
> E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
> 
> 
