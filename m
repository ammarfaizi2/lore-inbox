Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318427AbSGYLrp>; Thu, 25 Jul 2002 07:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSGYLrp>; Thu, 25 Jul 2002 07:47:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:61435 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318427AbSGYLro>; Thu, 25 Jul 2002 07:47:44 -0400
Subject: Re: FS corruption on Dell Inspiron 8k w/ IBM-DJSA-220
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Emil Eifrem <emil-spam@eifrem.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.1.20020725133008.01c251c0@quigon>
References: <4.1.20020725133008.01c251c0@quigon>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 14:04:51 +0100
Message-Id: <1027602291.9885.61.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 12:33, Emil Eifrem wrote:

> maestro3 ac97_codec soundcore agpgart NVdriver binfmt_misc autofs eepro100 ipc
> CPU:	0
> EIP:	0010:[<c01316e7>]	Tainted: P
> EFLAGS:	00010282

Please replicate the problem from a boot where you have never loaded
binary only drivers like NVdriver. That way we might actually be able to
try and debug it.

So I'd say get rid of NVdriver for a bit, force an fsck to check the
disk is clean then duplicate the corruption/crash and report it

