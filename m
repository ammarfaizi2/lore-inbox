Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316780AbSFUUXT>; Fri, 21 Jun 2002 16:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316782AbSFUUXS>; Fri, 21 Jun 2002 16:23:18 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:13031 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316780AbSFUUXR>; Fri, 21 Jun 2002 16:23:17 -0400
Date: Fri, 21 Jun 2002 15:23:13 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: William Lee Irwin III <wli@holomorphy.com>
cc: Erik McKee <camhanaich99@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUGREPORT] kernel BUG in page_alloc.c:141!
In-Reply-To: <20020621200613.GB22961@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0206211521130.14251-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2002, William Lee Irwin III wrote:

> On Fri, Jun 21, 2002 at 12:15:28PM -0700, Erik McKee wrote:
> > Booted 2.5.24, and it ran fine for sometime, before it dead(live) locked,
> > causing a reboot.  Attempts to reboot were met with the following bug
> > immediatly after calibrating delay loop, which equates out to an
> > if(bad_range(buddy1,zone)) BUG; in __free_pages_ok:
> 
> This looks odd. Can you by any chance disassemble the parts before this?
> Or better yet, reproduce it with a kernel compiled with -g and objdump
> --source --disassemble vmlinux to get the disassembly of __free_pages_ok()?

"make mm/page_alloc.lst" may simplify this task. However, the usage of the
various macros seems to confuse gcc -g / objdump somewhat, so the output
isn't as clear as it could be.

--Kai


