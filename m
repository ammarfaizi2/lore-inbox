Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262970AbTCYRGX>; Tue, 25 Mar 2003 12:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263029AbTCYRGX>; Tue, 25 Mar 2003 12:06:23 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:54416 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S262970AbTCYRGW>; Tue, 25 Mar 2003 12:06:22 -0500
Date: Tue, 25 Mar 2003 18:17:05 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Fionn Behrens <fionn@unix-ag.org>, <linux-kernel@vger.kernel.org>
Subject: Re: System time warping around real time problem - please help
In-Reply-To: <Pine.LNX.4.53.0303251152080.29361@chaos>
Message-ID: <Pine.LNX.4.33.0303251813530.15248-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, Richard B. Johnson wrote:

> On Tue, 25 Mar 2003, Fionn Behrens wrote:
>
> > I have got an increasingly annoying problem with our fairly new (fall
> > '02) Dual Athlon2k+ Gigabyte 7dpxdw linux system running 2.4.20.
> > The only kernel patch applied is Alan Cox's ptrace patch.
> >
>
[...]
> If this shows time jumping around you have one of either:
>
> (1)	Bad timer channel 0 chip (PIT).
> (2)	Some daemon trying to sync time with another system.
> (3)	You are traveling too close to the speed of light.

(4) Unsync'ed TSCs?

See help text for CONFIG_X86_TSC_DISABLE. Never had this problem
myself, though.

