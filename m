Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289015AbSAFTc3>; Sun, 6 Jan 2002 14:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289014AbSAFTcV>; Sun, 6 Jan 2002 14:32:21 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:51377 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289013AbSAFTcB>;
	Sun, 6 Jan 2002 14:32:01 -0500
From: dewar@gnat.com
To: dewar@gnat.com, guerby@acm.org, mrs@windriver.com
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020106193201.53A96F30AD@nile.gnat.com>
Date: Sun,  6 Jan 2002 14:32:01 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<I think the goal and intent, for Ada and C as well, is to say that the
compiler will generate what is possible from assembly code written by
an expert on the platform, using the best fitting access that is
possible.
>>

Ah ha! But then look again  at my 16-bit example, an expert assembly
langauge programmer will use a 32 bit load if efficiency is not an
issue (and it does not matter if there are extra bits around), but
a 16-bit load if the hardware for some reason requires it. How is
the poort C compiler to distinguish these cases automatically?
