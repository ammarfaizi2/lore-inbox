Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288297AbSAMXfN>; Sun, 13 Jan 2002 18:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288298AbSAMXfI>; Sun, 13 Jan 2002 18:35:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26892 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288297AbSAMXdw>; Sun, 13 Jan 2002 18:33:52 -0500
Subject: Re: Getting Out of Memory errors at random intervals.
To: abrink@ns.brink.cx (Andrew Brink)
Date: Sun, 13 Jan 2002 23:45:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020113232630.GA1149@ns.brink.cx> from "Andrew Brink" at Jan 13, 2002 05:26:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PuJq-0008NF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi. I've been getting random Out of Memory: Killing Processs pid (name)
> On _two_ different boxes. One is running 2.4.16 while the other 
> is 2.4.17.  Most of the time the process that gets killed is apache
> (these boxen are webservers) but sometimes its mysql, exim, htdig and
> others.
> 
> These boxes used to be rock stable, and now they get the OOM error at
> random periodic times.
> 
> Is there anything I can check for, or do to clear this up?

Run something that has a sane VM in all the known awkward cases (eg the Red Hat
2.4.9 tree) and you should be just fine. If not I'd be interested to know

For the newer trees I can only get stability under high loads with either the
Andrea -aa vm patches or Rik's rmap-11b patch. Both of which seem to help
no end.

Alan
