Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129373AbRAaXeC>; Wed, 31 Jan 2001 18:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbRAaXdw>; Wed, 31 Jan 2001 18:33:52 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46343 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129353AbRAaXdi>; Wed, 31 Jan 2001 18:33:38 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Why isn't init PID 1?
Date: 31 Jan 2001 15:33:09 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <95a7bl$jfu$1@cesium.transmeta.com>
In-Reply-To: <20010131144038.26689.qmail@web118.yahoomail.com> <Pine.LNX.4.21.0102010057470.11152-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0102010057470.11152-100000@server.serve.me.nl>
By author:    Igmar Palsenberg <maillist@chello.nl>
In newsgroup: linux.dev.kernel
> 
> Yes. First program to run get PID 1. 
> 
> Solution : fork() in init and load the modules in the child.
> 

Or finish your script with "exec init".

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
