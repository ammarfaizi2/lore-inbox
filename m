Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132741AbRC2O4C>; Thu, 29 Mar 2001 09:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132742AbRC2Ozw>; Thu, 29 Mar 2001 09:55:52 -0500
Received: from www.microgate.com ([216.30.46.105]:4371 "EHLO sol.microgate.com")
	by vger.kernel.org with ESMTP id <S132741AbRC2Ozo>;
	Thu, 29 Mar 2001 09:55:44 -0500
Message-ID: <007901c0b860$45ed6190$0146a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: <linux-kernel@vger.kernel.org>,
   "Krzysztof Halasa" <khc@intrepid.pm.waw.pl>
In-Reply-To: <m3itkuq6xt.fsf@intrepid.pm.waw.pl><20010328182729.A16067@se1.cogenit.fr><m34rwd8pj2.fsf@intrepid.pm.waw.pl><20010329112547.A23947@se1.cogenit.fr> <m33dbw7rzl.fsf@intrepid.pm.waw.pl>
Subject: Re: RFC: configuring net interfaces
Date: Thu, 29 Mar 2001 08:55:19 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Parameters for retransmission of a trame specified in Q922. t200 is the
> > timeout value and n200 the maximal number of retransmissions. They can
> > be negocied and default to t200=1,5s, n200=3.
> 
> Hmm... I've taken a look at it, but it seems to me that they are only
> used with "acknowledged multiple frame operation". Isn't it for ISDN only?
> With Frame Relay, we rather use unacknowledged transfers and UI frames.
> 
> Of course, if we have an implementation using t200, n200 or other
> parameters, they should be added to the structure.

It makes sense to me to defer adding the extra parameters
(as you suggest) until there is actual support for SVCs or
acknowledged mode over PVCs. The majority of what I've seen
is PVC/UI.

Paul Fulghum paulkf@microgate.com
Microgate Corporation www.microgate.com


