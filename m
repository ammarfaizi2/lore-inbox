Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVAMUnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVAMUnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVAMUez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:34:55 -0500
Received: from nexus.cs.usfca.edu ([138.202.170.4]:31131 "EHLO
	nexus.cs.usfca.edu") by vger.kernel.org with ESMTP id S261664AbVAMUd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:33:29 -0500
To: binutils@sources.redhat.com, cruse@cs.usfca.edu, hjl@lucon.org
Subject: Re: Change i386 assembler/disassembler for SIB with INDEX==4
Cc: gcc@gcc.gnu.org, libc-alpha@sources.redhat.com,
       linux-kernel@vger.kernel.org
Message-Id: <20050113203328.1174721A3F@nexus.cs.usfca.edu>
Date: Thu, 13 Jan 2005 12:33:28 -0800 (PST)
From: cruse@cs.usfca.edu (Allan B. Cruse)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jan 2005, "H. J. Lu" <hjl@lucon.org> wrote:
>
>
>
> Subject: Change i386 assembler/disassembler for SIB with INDEX==4
> 
> I am proposing to change i386 assembler/disassembler for SIB with
> INDEX==4
>                                                                                
> http://sources.redhat.com/bugzilla/show_bug.cgi?id=658
>                                                                                
> It will change the assembler output for (%ebx,[1248]). I am not too
> worried about the disassembler output since assembler can't generate
> SIB with INDEX==4 directly today. Any comments?
> 
> 
> H.J.
> 


This change would give programmers the freedom to write instruction-
syntax that the processor cannot actually execute, is that right?  

Perhaps the downside to this would lie in the hours of debugging and
private research each programmer would then be faced with, trying to
figure out why  " movl (%esi,2),%eax "  wasn't doing what he/she had
intended, and which the assembler had dutifully accepted.    --ABC



