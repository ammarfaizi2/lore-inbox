Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265385AbUBIUhm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 15:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbUBIUhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 15:37:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:36482 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265385AbUBIUhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 15:37:41 -0500
Date: Mon, 9 Feb 2004 15:40:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: moseleyt@colorado.edu
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: halting processor in SMT(Hyperthreading) system
In-Reply-To: <1076357703.4027ea47ed2e3@webmail.colorado.edu>
Message-ID: <Pine.LNX.4.53.0402091538170.12060@chaos>
References: <1076357703.4027ea47ed2e3@webmail.colorado.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004 moseleyt@colorado.edu wrote:

> Hello,
>
> I am doing research involving optimal scheduling for Hyperthreading systems.  I
> was curious if there was an easy way to arbitrarily halt/wake up a processor
> other than the one being run on from schedule().
>
> Thanks
>
> Tipp

The processor that executes a hlt instruction is the one
that will be halted. It takes an interrupt to get out of
that state.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


