Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135624AbRDZQF3>; Thu, 26 Apr 2001 12:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135681AbRDZQFT>; Thu, 26 Apr 2001 12:05:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46464 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135624AbRDZQFJ> convert rfc822-to-8bit; Thu, 26 Apr 2001 12:05:09 -0400
Date: Thu, 26 Apr 2001 12:05:01 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
cc: Eric PENNAMEN <pennamen@caramail.com>,
        liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: Fw: where can I find the IP address ?
In-Reply-To: <20010426174057.230044fd.sebastien.person@sycomore.fr>
Message-ID: <Pine.LNX.3.95.1010426115353.15486A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, [ISO-8859-1] sébastien person wrote:

> Le Thu, 26 Apr 2001 17:22:03 GMT+1
> Eric PENNAMEN <pennamen@caramail.com> à écrit :
> 
> > Je ne suis pas un expert Linux et je ne pourrais peut etre pas 
> > t'aider mais je le probleme n'es-t pas tres clair :
> > Est il de recuperer l'adresse IP du poste (transfert de donne
entre le script
> > et le driver au chargement) ?
> > ou bien que le driver doit ouvrir dans le kernel une socket a l'adresse IP donne dans le script 
> > et que tu ne sais pas comment faire ?
> 
[SNIPPED..]

Each device, when accessed, gets a pointer to a 'struct ifreq' this
structure contains the IP address as well as other network parameters.
See ../linux/net/core/dev.c  and /usr/include/linux/if.h.

This is readily address from user-space. I don't know if the required
stuff is public so it might require some work from a module.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


