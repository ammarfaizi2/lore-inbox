Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSLFPOr>; Fri, 6 Dec 2002 10:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSLFPOr>; Fri, 6 Dec 2002 10:14:47 -0500
Received: from [204.178.40.224] ([204.178.40.224]:35976 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262360AbSLFPOq>; Fri, 6 Dec 2002 10:14:46 -0500
Date: Fri, 6 Dec 2002 10:24:26 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Greg Boyce <gboyce@rakis.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dazed and Confused
In-Reply-To: <Pine.LNX.4.42.0212060948250.7121-100000@egg>
Message-ID: <Pine.LNX.3.95.1021206101514.21702A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2002, Greg Boyce wrote:

> Folks,
> 
> I have an issue that I've been trying to track down for some time, and I
> was hoping that someone might be able to provide me with a definitive
> awnser.
> 
> I work in a company with a large number of Linux machine deployed all
> around the country, and in some of the machines we've been seeing the
> following error:
> 
> Uhhuh. NMI received. Dazed and confused, but trying to continue
> You probably have a hardware problem with your RAM chips
> 

Hardware (read HARDWARE) generates a NMI when something BAD happens.
Linux didn't do it and Linux can't do anything about it. It just
reports that something bad happened (like a RAM parity error).

FYI Linux never "just needs to be re-booted". That response from
the computer maintenance department was implanted by the Redmond
group so they wouldn't have to fix their defective operating system(s).

Bad RAM, improperly socketed RAM, bad fans, bad power supplies,
bad heat-sinks, bad feature-cards, all kinds of bad components
can cause the NMI. Anything that will interfere with reading what
was written to RAM, including bad address-timing caused by the
box getting way too hot or the power supplies having noise or
sagging voltages, will cause this error.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


