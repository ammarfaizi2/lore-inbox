Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSAFNH1>; Sun, 6 Jan 2002 08:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSAFNHW>; Sun, 6 Jan 2002 08:07:22 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:51629 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S287865AbSAFNHC>;
	Sun, 6 Jan 2002 08:07:02 -0500
From: dewar@gnat.com
To: dewar@gnat.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020106130701.BE3F4F2FA1@nile.gnat.com>
Date: Sun,  6 Jan 2002 08:07:01 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<* Given an address as an int (of the appropriate size), I need a way
  to construct a pointer, which when dereferenced, will result in the
  CPU presenting that address to the MMU.

* I need a way to tell the compiler not to make any assumptions about
  what objects that such a pointer might or might not point to, so
  that the effect of dereferencing the pointer is simply to access the
  memory at the address I gave, and is not considered "undefined"
  regardless of how I might have constructed the address.
>>

So that seems reasonable as a statement of need (i.e. a high level
requirement), so what is needed now is to craft a well defined way
in GNU C, preferably other than ASM inserts, to achieve this very
reasonable goal.
