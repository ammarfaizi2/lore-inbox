Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbTARC7Y>; Fri, 17 Jan 2003 21:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbTARC7X>; Fri, 17 Jan 2003 21:59:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53048 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262208AbTARC7X>; Fri, 17 Jan 2003 21:59:23 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Mikael Pettersson <mikpe@csd.uu.se>,
       kai@tp1.ruhr-uni-bochum.de, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
References: <15911.64825.624251.707026@harpo.it.uu.se>
	<20030117135638.A376@flint.arm.linux.org.uk>
	<m1adhzg3fp.fsf@frodo.biederman.org>
	<20030117162104.GB1040@mars.ravnborg.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Jan 2003 20:08:08 -0700
In-Reply-To: <20030117162104.GB1040@mars.ravnborg.org>
Message-ID: <m1znpzdujr.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> On Fri, Jan 17, 2003 at 09:13:14AM -0700, Eric W. Biederman wrote:
> > That has been roughly my experience on x86 as well with the exception
> > of bss sections.  For bss sections placing the symbols inside the section
> > itself has been deadly.
> 
> Could you elaborate a bit more what you have seen?

Sorry.  Placing symbols inside .bss sections (sections by any name
that are not allocated) has occasionally given them values not as
expected.  While at the same time placing the symbols around the .bss
sections has worked reliably for me.

Eric
