Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285691AbSADWn6>; Fri, 4 Jan 2002 17:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285703AbSADWni>; Fri, 4 Jan 2002 17:43:38 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:5511 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S285691AbSADWn3>;
	Fri, 4 Jan 2002 17:43:29 -0500
From: dewar@gnat.com
To: fw@deneb.enyo.de, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020104224325.04B43F319D@nile.gnat.com>
Date: Fri,  4 Jan 2002 17:43:25 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Sorry, you are correct.  I should have written "One of the reasons why
C used to be a good language for writing operating system kernels ..."
>>

C is perfectly well suited for writing operating system kernels, but you
absolutely HAVE to know what you are doing, and that includes knowing the
C standard accurately, and clearly identifying any implementation dependent
behavior that you are counting on.

The "used to be" is bogus. The (base + offset) memory model of C has been
there since the earliest days of the definition of C. The only thing that
"used to be" the case is that people ignored these rules freely and since
compilers were fairly stupid, they got away with this rash behavior.

