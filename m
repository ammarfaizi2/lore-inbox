Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318206AbSGQEOt>; Wed, 17 Jul 2002 00:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318207AbSGQEOs>; Wed, 17 Jul 2002 00:14:48 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:44551
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S318206AbSGQEOr>; Wed, 17 Jul 2002 00:14:47 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: elladan@eskimo.com
X-Envelope-Sender: stevie@qrpff.net
Message-Id: <5.1.0.14.2.20020717001624.00ab8c00@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Jul 2002 00:17:40 -0400
To: Elladan <elladan@eskimo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Stevie O <stevie@qrpff.net>
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs
  benchmarks)
Cc: Zack Weinberg <zack@codesourcery.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020717022252.GA30570@eskimo.com>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
 <20020716232225.GH358@codesourcery.com>
 <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:22 PM 7/16/2002 -0700, Elladan wrote:
>  1. Thread 1 performs close() on a file descriptor.  close fails.
>  2. Thread 2 performs open().
>* 3. Thread 1 performs close() again, just to make sure.
>
>
>open() may return any file descriptor not currently in use.

I'm confused here... the only way close() can fail is if the file descriptor is invalid (EBADF); wouldn't it be rather stupid to close() a known-to-be-bad descriptor?


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

