Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTENPH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTENPH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:07:27 -0400
Received: from corky.net ([212.150.53.130]:9124 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S262431AbTENPHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:07:24 -0400
Date: Wed, 14 May 2003 18:20:06 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Ahmed Masud <masud@googgun.com>
Cc: Yoav Weiss <ml-lkml@unpatched.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
In-Reply-To: <Pine.LNX.4.33.0305141002500.10993-100000@marauder.googgun.com>
Message-ID: <Pine.LNX.4.44.0305141814410.12748-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do you see more options ?
> > Anyway, it should probably be policy controlled.
>
> These are all very good options, ofcourse things get hairy don't they :)

Certainly.  Option 3 certainly doesn't have to be implemented in the first
version :)
In fact, the first version could ignore the core dump issue and setrlimit
will be used to avoid core dumps of sensitive processes.  In the future,
it can be handled more gracefully.

> Perhaps in the beginning either 1, 2 and 4 as per a system wide dump
> policy. May be even a setrlimit extension and use that as a jump point to
> make a per user policy?

Makes sense.  Only when 3 is implemented, a special /proc interface is
required.  For everything else, setrlimit will suffice.

>
> Cheers,
>
> Ahmed.
>

Bye,
	Yoav

