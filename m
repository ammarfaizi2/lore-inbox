Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbTAWE1W>; Wed, 22 Jan 2003 23:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbTAWE1W>; Wed, 22 Jan 2003 23:27:22 -0500
Received: from [65.39.167.210] ([65.39.167.210]:61963 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S264853AbTAWE1V>;
	Wed, 22 Jan 2003 23:27:21 -0500
Date: Wed, 22 Jan 2003 23:36:31 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Tom Sanders <developer_linux@yahoo.com>
cc: redhat-list@redhat.com, <linux-kernel@vger.kernel.org>,
       <redhat-devel-list@redhat.com>
Subject: Re: Linux application level timers?
In-Reply-To: <20030122221703.42913.qmail@web9806.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0301222330080.7312-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Tom Sanders wrote:

> I'm writing an application server which receives
> requests from other applications. For each request
> received, I want to start a timer so that I can fail
> the application request if it could not be completed
> in max specified time.
>
> Which Linux timer facility can be used for this?
>
> I have checked out alarm() and signal() system calls,
> but these calls doesn't take an argument, so its not
> possible to associate application request with the
> matured alarm.
>
> Any inputs?

Write a timer funtion internal to your application that checks an
internal list of deadlines and when it gets the signal just check the
internal list to see what timer has gone off and set alarm() to the next
item.

If you want example code write me off list.

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

