Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbRERLbF>; Fri, 18 May 2001 07:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262294AbRERLaz>; Fri, 18 May 2001 07:30:55 -0400
Received: from [192.203.80.144] ([192.203.80.144]:23311 "HELO kaiser.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262296AbRERLan>;
	Fri, 18 May 2001 07:30:43 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105141821.WAA15869@ms2.inr.ac.ru>
Subject: Re: IPv6: the same address can be added multiple times
To: pekkas@netcore.fi (Pekka Savola)
Date: Mon, 14 May 2001 22:21:43 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105132319120.3026-100000@netcore.fi> from "Pekka Savola" at May 13, 1 11:26:23 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  2) no significant restrictions (==this)

When user asks to create some object, the only required thing
of any reasonable interface is to return an error when the object
is not added.

KAME's one is broken, ours is _one_ of right ones.


Another example of bad mistake is mine: I have made some crap with creating
tunnels: adding tunnel does not fail, when such tunnel already exists,
so that user has no idea, whether did it create tunnel (and should it
delete it) or someone another made this work. Note, that if we would
be able to create _duplicate_ tunnels on each new request (like IPv6 addresses),
this would be also right approach.

Alexey
