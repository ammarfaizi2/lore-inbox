Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135861AbRDTLKe>; Fri, 20 Apr 2001 07:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135862AbRDTLKY>; Fri, 20 Apr 2001 07:10:24 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:63506 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S135861AbRDTLKI> convert rfc822-to-8bit;
	Fri, 20 Apr 2001 07:10:08 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <15072.3502.60969.952690@argo.ozlabs.ibm.com.au>
Date: Fri, 20 Apr 2001 20:21:34 +1000 (EST)
To: Jeff Galloway <jeff.galloway@rundog.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.3 Compile Errors - Power Mac
In-Reply-To: <B7054E4B.424E%jeff.galloway@rundog.com>
In-Reply-To: <3ADF5555.3877759A@vnet.ibm.com>
	<B7054E4B.424E%jeff.galloway@rundog.com>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Galloway writes:

> Compiler error message:
> 
> fork.c: In function Œcopy_mm¹:
> fork.c:353: fixed or forbidden register 68 (0) was spilled for class
> CR0_REGS.
> This may be due to a compiler bug or to impossible asm statements or
> clauses.

You need a newer gcc, I suspect you have egcs installed, and you need
to upgrade to gcc-2.95.2 or later.

Paul.
