Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129841AbRCATqx>; Thu, 1 Mar 2001 14:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129840AbRCATqn>; Thu, 1 Mar 2001 14:46:43 -0500
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:56993 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129839AbRCATqf>; Thu, 1 Mar 2001 14:46:35 -0500
Message-ID: <3a9ea6fa3b646cc9@citronier.wanadoo.fr> (added by
	    citronier.wanadoo.fr)
From: "Sébastien HINDERER" <jrf3@wanadoo.fr>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Escape sequences & console
Date: Thu, 1 Mar 2001 20:48:10 -0000
X-MSMail-Priority: Normal
X-Priority: 3
X-Mailer: Microsoft Internet Mail 4.70.1161
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OKAY, but something strange appears:
According to linux/drivers/console.c, function setterm_commands, case 12,
one can change the virtual console by sending an escape sequence to
/dev/cnsole (what I want to do), hower, this is not documented in man
pages.
Which escape-sequence should I send to /dev/console to switch tty?
Thank you: Sébastien.



----------
> De : Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
> A : Sébastien HINDERER <jrf3@wanadoo.fr>
> Cc : linux-kernel@vger.kernel.org
> Objet : Re: Escape sequences & console
> Date : jeudi 1 mars 2001 18:21
> 
> On Thu, 1 Mar 2001, Sébastien HINDERER wrote:
> 
> > Could someone tell me where I can find a document listing all the
> > escape-sequences that could be sent to the console (/dev/console) and
what
> > they do.
> 
> Please don't use those sequences directly, as not everyone has
> /dev/console on a vt. You can find the information you want in your local
> terminfo database under "linux".
> 
>    Simon
> 
> -- 
> GPG public key available from
http://phobos.fs.tum.de/pgp/Simon.Richter.asc
>  Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
> Hi! I'm a .signature virus! Copy me into your ~/.signature to help me
spread!
> NP: Inside Treatement - Klaustraph
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
