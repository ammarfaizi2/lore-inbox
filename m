Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279087AbRJ2Jml>; Mon, 29 Oct 2001 04:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279088AbRJ2Jmc>; Mon, 29 Oct 2001 04:42:32 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:13710 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S279087AbRJ2Jm3>; Mon, 29 Oct 2001 04:42:29 -0500
From: Stefan Hoffmeister <lkml.2001@econos.de>
To: linux-kernel@vger.kernel.org
Subject: Re: sysenter support 
Date: Mon, 29 Oct 2001 10:37:08 +0100
Organization: Econos
Message-ID: <di8qtt8fc0e2qd7qgbc57f5ut7h33ofbnv@4ax.com>
In-Reply-To: <manfred@colorfullife.com>  of "Sun, 28 Oct 2001 11:02:35 BST." <3BDBD7BB.F7BE06D0@colorfullife.com> <200110290143.f9T1he1U001054@sleipnir.valparaiso.cl>
In-Reply-To: <200110290143.f9T1he1U001054@sleipnir.valparaiso.cl>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: On Sun, 28 Oct 2001 22:43:40 -0300, Horst von Brand wrote:

>AFAIKS you will need to
>be able to run an i686 glibc on an i386 (install!) kernel 

Why would you ever want to run a binary optimized for the i686 on a
i386-optimized kernel?

Typically you will want to have a "base" glibc around which really
serves the lowest common denominator (i386) and then optimized versions
in the i686 / mmx / sse subdirectories which will run whenever it is
possible to run
