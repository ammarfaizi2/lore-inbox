Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUIAMV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUIAMV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUIAMV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:21:26 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:64167 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266252AbUIAMVM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:21:12 -0400
From: Romain Moyne <aero_climb@yahoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Time runs exactly three times too fast
Date: Thu, 2 Sep 2004 16:14:09 +0200
User-Agent: KMail/1.7
References: <200409021453.09730.aero_climb@yahoo.fr> <Pine.LNX.4.58.0409010814580.4481@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0409010814580.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409021614.10377.aero_climb@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mercredi 01 Septembre 2004 14:15, Zwane Mwaikambo a écrit :
> On Thu, 2 Sep 2004, Romain Moyne wrote:
> > Hello, I'm french, sorry for my bad english :(
> >
> > I have a problem with my kernel: Time runs exactly three times too fast.
> >
> > I tested the kernel 2.6.8.1 and the 2.6.9-rc1, no success.
> > It is really strange because yesterday I reinstalled my debian with a
> > kernel 2.6.8.1 (made by me): Time ran correctly. And this morning when I
> > rebooted my computer (Compaq presario R3000 series, R3215EA exactly) the
> > time is running again three times too fast (with the kernel 2.6.8.1 and
> > 2.6.9-rc1).
> >
> > All my applications (KDE, command "date"...) runs three times too fast.
> > It's very annoying.
>
> Can you try this without cpuspeed or some frequency control daemon
> running? So disable it in runlevel scripts and then reboot.

I have not cpuspeed or some frequency control daemon running. I just have 
this:

presario:/etc/rc2.d# ls
S10sysklogd  S20alsa   S20makedev  S20xprint  S99kdm            S99xdm
S11klogd     S20exim4  S20pcmcia   S89atd     S99rmnologin
S14ppp       S20inetd  S20xfs      S89cron    S99stop-bootlogd
presario:/etc/rc2.d#

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
