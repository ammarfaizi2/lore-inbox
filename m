Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269476AbRGaVZN>; Tue, 31 Jul 2001 17:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269475AbRGaVYz>; Tue, 31 Jul 2001 17:24:55 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:7694 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269474AbRGaVYv>; Tue, 31 Jul 2001 17:24:51 -0400
Date: Tue, 31 Jul 2001 23:24:56 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.2.13] memory leak in NFS if a sever goes away?
Message-ID: <20010731232456.A13258@emma1.emma.line.org>
Mail-Followup-To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>,
	linux-kernel@vger.kernel.org
In-Reply-To: <tgsnfdkrsu.fsf@mercury.rus.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <tgsnfdkrsu.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Florian Weimer schrieb am Dienstag, den 31. Juli 2001:

> We've received a hard disk for post-mortem analysis because of a
> strange hole of several months in the system logs, and it seems the
> system's syslogd was killed by the VM subsystem during an OOM
> situation.

If it's crucial, list it in inittab.

> Are there some known issues with 2.2.13, for example, a memory leak in
> the NFS code which is triggered in this specific situation?

There are known security threats in 2.2.x which have been fixed in
2.2.16, and there have been VM fixes in a later version, and further
minor but numerable security fixes in 2.2.19.

Update to 2.2.19. Don't bother analyzing 2.2.13, no-one fixes that
nowadays unless the problem persists in 2.2.19.
