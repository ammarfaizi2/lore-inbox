Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287816AbSASNja>; Sat, 19 Jan 2002 08:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289031AbSASNjV>; Sat, 19 Jan 2002 08:39:21 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:8134 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S287816AbSASNjJ>; Sat, 19 Jan 2002 08:39:09 -0500
From: Christoph Rohland <cr@sap.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Wilhelm Nuesser <wilhelm.nuesser@sap.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: clarification about redhat and vm
In-Reply-To: <E16RFE9-00042W-00@the-village.bc.nu> <3C485169.7070005@sap.com>
	<20020118200700.A21279@athlon.random>
Organisation: SAP LinuxLab
Date: Sat, 19 Jan 2002 11:50:59 +0100
In-Reply-To: <20020118200700.A21279@athlon.random> (Andrea Arcangeli's
 message of "Fri, 18 Jan 2002 20:07:01 +0100")
Message-ID: <m3wuye397w.fsf@linux.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Fri, 18 Jan 2002, Andrea Arcangeli wrote:
> and I assume you were using either ext2 or reiserfs anyways, so the
> fsync problem never affected you since the first place (also with
> older kernels) I believe.

It was done on ext2 _and_ against raw devices. Same dendency on both
setups.

Further on I doubt the test is very depended on fsync. It should be
swap io limited since it runs with a way too small memory
configuration.

If you have enough memory the test is not very IO intensive either
despite the fact that a big database is running. To bring the database
really into IO you have to add application servers. (Fujitsu Siemens
took 160 4way Linux servers to saturate a database server running
Solaris on 64way FSC Primepower.)

BTW since we are just bashing VMs: I always hear that 2.2 is so much
better: The first 2.2 kernel which could really survive this test was
2.2.19!

Greetings
		Christoph



