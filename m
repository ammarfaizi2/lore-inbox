Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbTAOBLa>; Tue, 14 Jan 2003 20:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbTAOBLa>; Tue, 14 Jan 2003 20:11:30 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:40680 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S265670AbTAOBL3>;
	Tue, 14 Jan 2003 20:11:29 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200301150119.EAA14364@sex.inr.ac.ru>
Subject: Re: [RFC] Migrating net/sched to new module interface
To: zippel@linux-m68k.org (Roman Zippel)
Date: Wed, 15 Jan 2003 04:19:28 +0300 (MSK)
Cc: kronos@kronoz.cjb.net, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <3E24A981.1EA03E8B@linux-m68k.org> from "Roman Zippel" at Jan 15, 3 01:21:21 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Above scheme is not without problems either, a failing try_module_get()
> suddenly gets a double meaning. Now it also means that the module might
> be ready soon, please try again later,

... and btw completely useless thing, because each module user already
has its own means to do serialization of this kind even when used _NOT_
as module.

Somewhat overdone.

Alexey
