Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289840AbSAOOzY>; Tue, 15 Jan 2002 09:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289876AbSAOOzO>; Tue, 15 Jan 2002 09:55:14 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:39331 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S289840AbSAOOzG>; Tue, 15 Jan 2002 09:55:06 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Felix von Leitner <felix-dietlibc@fefe.de>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org, andersen@codepoet.org
Date: Tue, 15 Jan 2002 06:54:46 -0800 (PST)
Subject: Re: [RFC] klibc requirements
In-Reply-To: <20020115115544.GA20020@codeblau.de>
Message-ID: <Pine.LNX.4.40.0201150649430.23491-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Felix von Leitner wrote:

> Date: Tue, 15 Jan 2002 12:55:44 +0100
> From: Felix von Leitner <felix-dietlibc@fefe.de>
> To: Albert D. Cahalan <acahalan@cs.uml.edu>
> Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
>      andersen@codepoet.org
> Subject: Re: [RFC] klibc requirements
>
> Thus spake Albert D. Cahalan (acahalan@cs.uml.edu):
> > I think the dietlibc idea has to be scrapped so we can run BSD apps.
> > (and others maybe, but I'm not looking to start a flame war)
>
> What apps are you talking about?

he's talking about licencing issues.

LGPL libc replacements can be used with any program, GPL libc replacements
can only be used with programs licenced in a way that can be combined with
GPL (and the resulting program is GPL.

as an example (not for the boot process, but an example of a replacement
libc use) I use the firewall toolkit, it has been around for a _loooong_
time (in software terms anyway) and has a firly odd licence (free for you
to use, source available, cannot sell it) which is not compatable with the
GPL. with glibc staticly linked this makes huge binaries, with libc5 they
were a lot smaller. I would like to try to use this small libc for these
proxies, but if the library is GPL, not LGPL I'm not allowed to.

David Lang
