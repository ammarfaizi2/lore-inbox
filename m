Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbULDL2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbULDL2b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 06:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbULDL2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 06:28:31 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:34615 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261654AbULDL23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 06:28:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=U3MTJC5uXTAk9buErC5WwgC0NSeRz3LRCdS4DBSese6/2Za2WQe+KFpchbuszzY3FsqeixucA2gVN0nz7Jwwl9EgPahATyO8bFqbibCO9PgEq5CVKLK7Y1IdeAoFvHfRSDaUs7+SKv2sAVdBgI6wPRahufA9W3EVYnAgEKgaaaw=
Message-ID: <35fb2e5904120403281a63eccd@mail.gmail.com>
Date: Sat, 4 Dec 2004 11:28:28 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] UML - SYSEMU fixes
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
In-Reply-To: <200412032145.iB3LjQZW004710@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412032145.iB3LjQZW004710@ccure.user-mode-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2004 16:45:26 -0500, Jeff Dike <jdike@addtoit.com> wrote:

> Usage of SYSEMU in TT mode is modified, so that always the
> same method is used in do_syscall as has been used before in
> ptrace(PTRACE_SYSCALL/SYSEMU, ...)

That's great, but do any of these patches address various undefines in
arch/um/kernel/process.c:check_sysemu when built without skas?

Jon.
