Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277001AbRJHQkr>; Mon, 8 Oct 2001 12:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276987AbRJHQkh>; Mon, 8 Oct 2001 12:40:37 -0400
Received: from dsl-64-130-65-177.telocity.com ([64.130.65.177]:6394 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S276477AbRJHQk3>; Mon, 8 Oct 2001 12:40:29 -0400
Subject: Re: sun + gigabit nic
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
To: kernel@ddx.a2000.nu
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0110061843230.12443-100000@ddx.a2000.nu>
In-Reply-To: <Pine.LNX.4.40.0110061843230.12443-100000@ddx.a2000.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 08 Oct 2001 09:44:13 -0700
Message-Id: <1002559480.2837.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-06 at 09:44, kernel@ddx.a2000.nu wrote:

> so will the netgear gigabit adapter work with the ultrasparc linux kernel
> ?
> (the netgear ga622t ?)

this is netgear's gige over copper card. it does not use the acenic
chip.  instead it uses the national semiconductor 83820 chip and a
different driver. this driver did not go into the kernel until ~2.4.10
(ns83820.c) and does not work under sparc64 so far -- it seems to
compile, load into the kernel, receive ethernet packets, but packets
never get to layer 3 AFAICT.  if anybody has had better luck, please let
me know.

btw, anybody know where to get acenic gige copper cards anywhere? for
the life of me, I cannot find a place that sells them anymore.

-tduffy 

