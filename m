Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVJMMl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVJMMl5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 08:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbVJMMl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 08:41:57 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:17042 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751307AbVJMMl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 08:41:57 -0400
Date: Thu, 13 Oct 2005 08:41:43 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Mark Knecht <markknecht@gmail.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-rt1 - enable IRQ-off tracing causes kernel to fault
 at boot
In-Reply-To: <5bdc1c8b0510130526k6064c640pecded9ccb0ef7dde@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0510130832500.13098@localhost.localdomain>
References: <5bdc1c8b0510121000i5db112f2p642f66686fb46c57@mail.gmail.com> 
 <20051013073029.GA12801@elte.hu> <5bdc1c8b0510130526k6064c640pecded9ccb0ef7dde@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Oct 2005, Mark Knecht wrote:

> Guitar player doesn't do serial ports? ;-)
>
> OK, I've never done anything like this before, but I'm motivated so
> I'll give it a shot. Hopefully I can make some headway without having
> to ask too many stupid questions, such as the one that follows:
>
> Question: Is a 'null modem' cable just a plain serial cable, or is it
> a special serial cable I need to go buy?
>

There's two types of "plain serial cables".  A 'null modem' and a 'non
null modem'.  The 'null modem' cable allows for two computers connected
together by their serial ports to talk to each other.  This is because the
'null modem' cable crosses the wires so input connects to output and so
forth.  A 'non-null modem' cable is a direct straight through.  So you
can connect multiple 'non-null' modem cables together and it will still be
a non-null modem cable. In fact you can connect one or more non-null to a
null modem cable and it will still be a null modem cable (just longer).
So make sure that you get a 'null modem' cable.

Make sure you have the CONFIG_SERIAL_CONSOLE (or
CONFIG_SERIAL_8250_CONSOLE) set. And then read
Documentation/serial-console.txt


-- Steve

