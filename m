Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbRE2XRR>; Tue, 29 May 2001 19:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262421AbRE2XRH>; Tue, 29 May 2001 19:17:07 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:62181 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262415AbRE2XQ6>;
	Tue, 29 May 2001 19:16:58 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105292316.QAA00305@csl.Stanford.EDU>
Subject: Re: [CHECKER] 4 security holes in 2.4.4-ac8
To: davem@redhat.com (David S. Miller)
Date: Tue, 29 May 2001 16:16:54 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15124.10785.10143.242660@pizda.ninka.net> from "David S. Miller" at May 29, 2001 04:00:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > (Also, are there other functions called 
>  > directly from user space that don't have the sys_* prefix?)
> 
> Almost certainly, arch/i386/mm/fault.c:do_page_fault is one of
> many examples.

Is there any way to automatically find these?  E.g., is any routine
with "asmlinkage" callable from user space?

Dawson
