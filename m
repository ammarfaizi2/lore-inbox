Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSADWQZ>; Fri, 4 Jan 2002 17:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285110AbSADWQQ>; Fri, 4 Jan 2002 17:16:16 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:31500 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S285060AbSADWP4>;
	Fri, 4 Jan 2002 17:15:56 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15414.10574.518266.221241@argo.ozlabs.ibm.com>
Date: Sat, 5 Jan 2002 09:14:38 +1100 (EST)
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Momchil Velikov <velco@fadata.bg>, Tom Rini <trini@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87itai32rg.fsf@deneb.enyo.de>
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020101234350.GN28513@cpe-24-221-152-185.az.sprintbbd.net>
	<87ital6y5r.fsf@fadata.bg>
	<15411.36909.387949.863222@argo.ozlabs.ibm.com>
	<87itai32rg.fsf@deneb.enyo.de>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer writes:

> Paul Mackerras <paulus@samba.org> writes:
> 
> > One of the reasons why C is a good language for the kernel is that its
> > memory model is a good match to the memory organization used by the
> > processors that linux runs on.  Thus, for these processors, adding an
> > offset to a pointer is in fact simply an arithmetic addition.
> 
> But this is not the memory model of C!  Adding an offset to a pointer
> is an operation involving objects defined by the C language, and not
> machine registers.  Sometimes, this makes a noticeable difference.

Sorry, you are correct.  I should have written "One of the reasons why
C used to be a good language for writing operating system kernels ..."

Paul.
