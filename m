Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288601AbSADMPo>; Fri, 4 Jan 2002 07:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSADMPf>; Fri, 4 Jan 2002 07:15:35 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:58616 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288601AbSADMPW>;
	Fri, 4 Jan 2002 07:15:22 -0500
From: dewar@gnat.com
To: fw@deneb.enyo.de, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020104121521.3B9FAF3127@nile.gnat.com>
Date: Fri,  4 Jan 2002 07:15:21 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<But this is not the memory model of C!  Adding an offset to a pointer
is an operation involving objects defined by the C language, and not
machine registers.  Sometimes, this makes a noticeable difference.
>>

Indeed Alex Stepanov notes that Ada unlike C, *does* have general pointer
arithmetic, assuming a linear address space, and finds the lack of this in
C a problem :-) :-)
