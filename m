Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbTJBPCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 11:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTJBPCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 11:02:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:39121 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263393AbTJBPCQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 11:02:16 -0400
Date: Thu, 2 Oct 2003 08:03:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test6-mm2
Message-Id: <20031002080335.0f75fade.akpm@osdl.org>
In-Reply-To: <1065102346.14567.12.camel@telecentrolivre>
References: <20031002022341.797361bc.akpm@osdl.org>
	<1065102346.14567.12.camel@telecentrolivre>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br> wrote:
>
> Em Qui, 2003-10-02 às 06:23, Andrew Morton escreveu:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm2/
> 
>  getting this with gcc-3.2:
> 
>  net/core/flow.c:406: warning: type defaults to `int' in declaration of `EXPORT_SYMBOL'
>  net/core/flow.c:406: warning: parameter names (without types) in function declaration
>  net/core/flow.c:406: warning: data definition has no type or storage class
>  net/core/flow.c:407: warning: type defaults to `int' in declaration of `EXPORT_SYMBOL'
>  net/core/flow.c:407: warning: parameter names (without types) in function declaration
>  net/core/flow.c:407: warning: data definition has no type or storage class

It works OK for me, and flow.c correctly includes module.h.  Could you
double-check that your tree is not damaged in some manner?

