Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262705AbTCYQIU>; Tue, 25 Mar 2003 11:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262706AbTCYQIU>; Tue, 25 Mar 2003 11:08:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12942 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262705AbTCYQIT>; Tue, 25 Mar 2003 11:08:19 -0500
Date: Tue, 25 Mar 2003 11:21:41 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Edgardo Hames <ehames@scdt.frc.utn.edu.ar>
cc: linux-kernel@vger.kernel.org
Subject: Re: Error accessing memory between 0xc0000 and 0x100000
In-Reply-To: <200303251308.36565.ehames@scdt.frc.utn.edu.ar>
Message-ID: <Pine.LNX.4.53.0303251119420.29139@chaos>
References: <200303251308.36565.ehames@scdt.frc.utn.edu.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, Edgardo Hames wrote:

> Hi everybody. I'm trying to write a simple device driver to read and write
> memory at addresses beween 0xc0000 and 0x100000, but when I try to load the
> module I get the following error:
>

Check out ioremap(). Although the addresses you show are already
mapped, you need to access them with the "cookie" returned from
ioremap().


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

