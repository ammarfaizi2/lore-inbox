Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVCHR25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVCHR25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVCHR24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:28:56 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:42281 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261431AbVCHR1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:27:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ftkp9HKaGzYmUoVCnWbFXfmBBBuyREOC1aWs8o0DN+EDpzPV/H2H5NVv6osqOiB3RDdyesLRuZr05c7WnhcWb1w+G6cER9yA7kz+4HTI1dFF0AznksEsn7ussYW+ow2nu/YYGf5SPU6vtla5kDmWBJDtz1ORpUVgKfJEyoeftYU=
Message-ID: <c26b959205030809271b8a5886@mail.gmail.com>
Date: Tue, 8 Mar 2005 22:57:26 +0530
From: Imanpreet Arora <imanpreet@gmail.com>
Reply-To: Imanpreet Arora <imanpreet@gmail.com>
To: Robert Love <rml@novell.com>
Subject: Re: Question regarding thread_struct
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1110302000.23923.14.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <c26b959205030809044364b923@mail.gmail.com>
	 <1110302000.23923.14.camel@betsy.boston.ximian.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2005 12:13:20 -0500, Robert Love <rml@novell.com> wrote:
> On Tue, 2005-03-08 at 22:34 +0530, Imanpreet Arora wrote:
> 
> >       I am wondering if someone could provide information as to how
> > thread_struct is kept in memory. Robert Love mentions that it is kept
> > at the "lowest"  kernel address in case of x86 based platform. Could
> > anyone answer these questions.
> 
> Kernel _stack_ address for the given process.
> 
> > a)    When a stack is resized, is the thread_struct structure copied onto
> > a new place?
> 
> This is the kernel stack, not any potential user-space stack.  Kernel
> stacks are not resized.

This has been a doubt for a couple of days, and I am wondering if this
one could also be cleared. When you say kernel stack, can't be resized


a)       Does it mean that the _whole_ of the kernel is restricted to
that 8K or 16K of memory?

b)        Or does it mean that a particular stack for a particular
process, can't be resized?

c)         And for that matter how exactly do we define a kernel stack?

TIA                     
-- 

Imanpreet Singh Arora
