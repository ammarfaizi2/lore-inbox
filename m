Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSLFPW2>; Fri, 6 Dec 2002 10:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSLFPW2>; Fri, 6 Dec 2002 10:22:28 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:33966 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263228AbSLFPW0>; Fri, 6 Dec 2002 10:22:26 -0500
Subject: Re: Dazed and Confused
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg Boyce <gboyce@rakis.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.42.0212060948250.7121-100000@egg>
References: <Pine.LNX.4.42.0212060948250.7121-100000@egg>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 16:05:19 +0000
Message-Id: <1039190719.22971.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 14:55, Greg Boyce wrote:
> I work in a company with a large number of Linux machine deployed all
> around the country, and in some of the machines we've been seeing the
> following error:
> 
> Uhhuh. NMI received. Dazed and confused, but trying to continue
> You probably have a hardware problem with your RAM chips

There are several causes of an NMI depending on the system - hardware
failures is one, some systems do it for things like PCI errors, a few
boxes you see them on power management events (notably old 486's)

> Due to the number of machines and their locations, running memtest86 on
> them isn't exactly feasible.

Then buy better ram ;)

> Is there anything besides failing hardware that could be the cause of this
> error?  Also, how serious is this error?  Some of the machines reporting
> this error have had problems with programs crashing, while others seem to
> run fine.

Take a sample set of machines which have been crashing and run memtest86
on a couple. That should tell you if it is RAM. From a sample you can
then figure out how to handle the rest (things that come to mind if
memtest86 fails on the test machines include replacing the ram in a few
more then taking the old ram back to test)


