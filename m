Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276642AbRJGXqs>; Sun, 7 Oct 2001 19:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276647AbRJGXqj>; Sun, 7 Oct 2001 19:46:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16654 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276642AbRJGXq2>; Sun, 7 Oct 2001 19:46:28 -0400
Date: Sun, 7 Oct 2001 16:46:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
cc: Adrian Bunk <bunk@fs.tum.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.11-pre5
In-Reply-To: <3BC0C655.6C35DF43@oracle.com>
Message-ID: <Pine.LNX.4.33.0110071643050.7542-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Oct 2001, Alessandro Suardi wrote:
>
> Happens also for ieee1394 when built as module.

Add "ohci1394.o" to the list of export-objs in ieee1349/Makefile.

As to the exec_domain.c one - that one is already on the export-obhjs
list, and I wonder if perhaps Adrian forgot to do a "make dep" or
similar...

		Linus

