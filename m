Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbTASCdP>; Sat, 18 Jan 2003 21:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbTASCdP>; Sat, 18 Jan 2003 21:33:15 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:3342 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265355AbTASCdP>; Sat, 18 Jan 2003 21:33:15 -0500
Date: Sun, 19 Jan 2003 00:41:55 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Paul E. Erkkila" <pee@erkkila.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: oops - 2.5.59 fdisk USB 2.0 disk
Message-ID: <20030119024155.GG7519@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Paul E. Erkkila" <pee@erkkila.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E2A0DFC.6000508@erkkila.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2A0DFC.6000508@erkkila.org>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 19, 2003 at 02:31:24AM +0000, Paul E. Erkkila escreveu:
> Got this (forced) oops putting together a new pc this weekend.
 
> This is from and fdisk of /dev/sda. Attached to an intel 845
> based motherboard. No preempt, acpi, config attached.

> devfs_put(cee1ca00): poisoned pointer

Could you try without devfs enabled or using Andrew Morton's -mm tree that
has Adam J. Richter's devfs rewrite?

- Arnaldo
