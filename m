Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318263AbSHZTDe>; Mon, 26 Aug 2002 15:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318252AbSHZTCk>; Mon, 26 Aug 2002 15:02:40 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:6398 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318210AbSHZTBp>; Mon, 26 Aug 2002 15:01:45 -0400
Subject: Re: [BUG/PATCH] : bug in tty_default_put_char()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020826185930.GA8749@bougret.hpl.hp.com>
References: <20020826180749.GA8630@bougret.hpl.hp.com>
	<1030388224.2797.2.camel@irongate.swansea.linux.org.uk> 
	<20020826185930.GA8749@bougret.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 20:07:27 +0100
Message-Id: <1030388847.2776.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 19:59, Jean Tourrilhes wrote:
> 	Just check drivers/char/n_tty.c for every occurence of
> put_char() and be scared. The problem is to find a practical solution.
> 	For myself, I've added some clever workaround in IrCOMM to
> accept data before full setup.

Sure making it return the right errors doesnt fix anything, but it
allows you to fix some of it bit by bit. 

