Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278313AbRJZKza>; Fri, 26 Oct 2001 06:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278325AbRJZKzU>; Fri, 26 Oct 2001 06:55:20 -0400
Received: from AMontpellier-201-1-4-3.abo.wanadoo.fr ([217.128.205.3]:15889
	"EHLO awak") by vger.kernel.org with ESMTP id <S278313AbRJZKzG> convert rfc822-to-8bit;
	Fri, 26 Oct 2001 06:55:06 -0400
Subject: Re: [livid-gatos] [RFC] alternative kernel multimedia API
From: Xavier Bestel <xavier.bestel@free.fr>
To: volodya@mindspring.com
Cc: Nate Dannenberg <natedac@kscable.com>, livid-gatos@linuxvideo.org,
        video4linux-list@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.20.0110251911520.9634-100000@node2.localnet.net>
In-Reply-To: <Pine.LNX.4.20.0110251911520.9634-100000@node2.localnet.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16.99+cvs.2001.10.22.19.14 (Preview Release)
Date: 26 Oct 2001 12:35:30 +0200
Message-Id: <1004092530.10130.145.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le ven 26-10-2001 à 01:14, volodya@mindspring.com a écrit :

> >  05,HUE=7\n
> >  07,some unrelated command
> > +05\n				# The HUE command was successful
> > :07,reply to unrelated command
> > :05,HUE=6\n			# Driver reported the HUE parameter as

I would prefer a proc-like interface to devices, e.g.:

/dev/video0/hue
/dev/video0/saturation
...

more unix-like, no parsing involved.

	Xav

