Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289889AbSAPHuh>; Wed, 16 Jan 2002 02:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290383AbSAPHua>; Wed, 16 Jan 2002 02:50:30 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:55559 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S289889AbSAPHuT>;
	Wed, 16 Jan 2002 02:50:19 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201160750.g0G7oBg70888@saturn.cs.uml.edu>
Subject: Re: [RFC] klibc requirements
To: felix-dietlibc@fefe.de (Felix von Leitner)
Date: Wed, 16 Jan 2002 02:50:11 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), greg@kroah.com (Greg KH),
        linux-kernel@vger.kernel.org, andersen@codepoet.org
In-Reply-To: <20020115115544.GA20020@codeblau.de> from "Felix von Leitner" at Jan 15, 2002 12:55:44 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner writes:
> Thus spake Albert D. Cahalan (acahalan@cs.uml.edu):

>> I think the dietlibc idea has to be scrapped so we can run BSD apps.
>> (and others maybe, but I'm not looking to start a flame war)
>
> What apps are you talking about?

I'm talking about all apps under the traditional 4-clause
BSD license. Every single one of them is incompatible with
a GPL libc. An LGPL library works fine.

BTW, the LGPL isn't just for libraries anymore. It's now the
called the "Lesser" GPL, perfectly suited for apps as well
as libraries. I know this must be what RMS had in mind, so I
released all my "ps" source code under the LGPL. :-)

> You don't need NIS or SMB before mounting the root disk.

NIS can be used to specify what filesystem to use.
SMB could be that filesystem.

>> Treat ELF like a.out, getting rid of the -fPIC stuff in favor of
>> offsets assigned when you build the initramfs.
>
> ELF is a standard.
> You can't just go out and re-invent dynamic linking completely.

Sure you can. As long as the kernel loader is happy, no problem.
People commit worse sins trying to squeeze stuff onto a floppy.
