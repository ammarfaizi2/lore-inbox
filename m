Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSGFR7l>; Sat, 6 Jul 2002 13:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSGFR7k>; Sat, 6 Jul 2002 13:59:40 -0400
Received: from www.transvirtual.com ([206.14.214.140]:18442 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315720AbSGFR7k>; Sat, 6 Jul 2002 13:59:40 -0400
Date: Sat, 6 Jul 2002 11:02:11 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alessandro Suardi <alessandro.suardi@oracle.com>
Subject: Re: 2.5.25 dead kbd and gpm oops (my config error ?)
In-Reply-To: <Pine.LNX.4.44.0207061928140.1712-100000@kai.makisara.local>
Message-ID: <Pine.LNX.4.44.0207061100270.26054-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I lost my keyboard and USB mouse (no gpm running and no oops).
>
> The temporary solution seems to be to leave out the drivers for serial i/o
> in input i/o  drivers.

:-(

> There is another keyboard driver unconditionally
> included and it conflicts with the new i8042 driver. Here is my input
> configuration:

Unfortunely this is a major problem.

> I guess this problem will be corrected when the input changes continue.

The problem will go away once pc_keyb.c goes away and every keyboard
driver moves over to the input api. You will see this change in the next
few weeks.

