Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbULDLgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbULDLgD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 06:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbULDLgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 06:36:03 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:55115 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261657AbULDLf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 06:35:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DT6PwQh83XeErUTxGHeZudg5ajkjut9X1ZzPkgJKEf2sGwvZdV2kSd139d2KTylaShaWPce5LsIh5L+w1Zd1SJHeWgNOg4SofxP8pPBaNmUlx8deyEcxy9xxyNL63fAPGmCptck6Lk/rljV7jSikQCke+yrdy3suzebPaiOnTvE=
Message-ID: <35fb2e59041204033566073186@mail.gmail.com>
Date: Sat, 4 Dec 2004 11:35:58 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] UML - SYSEMU fixes
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
In-Reply-To: <35fb2e5904120403281a63eccd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412032145.iB3LjQZW004710@ccure.user-mode-linux.org>
	 <35fb2e5904120403281a63eccd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2004 11:28:28 +0000, Jon Masters <jonmasters@gmail.com> wrote:
> On Fri, 03 Dec 2004 16:45:26 -0500, Jeff Dike <jdike@addtoit.com> wrote:
> 
> > Usage of SYSEMU in TT mode is modified, so that always the
> > same method is used in do_syscall as has been used before in
> > ptrace(PTRACE_SYSCALL/SYSEMU, ...)
> 
> That's great, but do any of these patches address various undefines in
> arch/um/kernel/process.c:check_sysemu when built without skas?

Also, on 2.6.9, I get dud CFLAGS defined when CONFIG_PROF is set *and*
CONFIG_FRAME_POINTER is also set - gcc complains about use of "-gp"
and "-fomit-frame-pointer" but surely it should be building with frame
pointers anyway if I've asked it to do so?

Jon.
