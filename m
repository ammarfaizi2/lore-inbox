Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288950AbSAFNlk>; Sun, 6 Jan 2002 08:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288952AbSAFNla>; Sun, 6 Jan 2002 08:41:30 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:16814 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288950AbSAFNlK>;
	Sun, 6 Jan 2002 08:41:10 -0500
From: dewar@gnat.com
To: dewar@gnat.com, gdr@codesourcery.com
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020106134110.62076F2FA1@nile.gnat.com>
Date: Sun,  6 Jan 2002 08:41:10 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Isn't the incriminated construct already outside of C and non-portable?

The issue is not whether it is outside standard-C here, which of course
it is, but rather whether there is some extension to GNU-C (either an
interpretation of undefined or implementation defined, or an attribute etc)
which wuld make it inside GNU-C even if outside C, and therefore portable
to GNU-C, which is good enough for this purpose.
