Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289627AbSA2OfM>; Tue, 29 Jan 2002 09:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289385AbSA2Oex>; Tue, 29 Jan 2002 09:34:53 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:6640 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S289627AbSA2Oes>; Tue, 29 Jan 2002 09:34:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: ext2 fs corruption and usb devices
Date: Tue, 29 Jan 2002 15:34:36 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201290831360.20095-100000@netfinity.realnet.co.sz> <3C5691F0.30105@wanadoo.fr>
In-Reply-To: <3C5691F0.30105@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VZLJ-0001JO-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 January 2002 1:13 pm, Pierre Rousselet wrote:
> Zwane Mwaikambo wrote:
> > But i still think proprietory modules showing up in problem traces is
> > usually enough to warrant the trace as useless. The fact that it works
> > now and not then could be anybody's guess.
>
> The kernel module is actually open-source and could even be merged in
> the kernel tree. If the modem was smart it would run its own firmware
> without relying on the client's machine to do it.
>
> Q1: Are the ST USB drivers for Linux completely Open Source ?
>
> A1: Alcatel supports the Open Source Movement, but feels it has to
> protect it's Intellectual property. Therefore, The drivers are only
> partially Open Source.
> There is a open source kernel-module (GPL) and a closed source
> management application. The management application is distributed as a
> binary and contains the firmware.

It should be possible to replace the Alcatel management application using
code from the user space speedtouch driver project
(see http://speedtouch.sourceforge.net).  Of course the firmware uploaded
to the modem would still be closed source, but no closed source program
would run on the computer.  Since the module is open-source (GPL) there
is no problem adding the appropriate licence symbol to it, avoiding the "tainted"
problem.

All the best, Duncan.
