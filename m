Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVFFMYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVFFMYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 08:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVFFMYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 08:24:46 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:43929 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261359AbVFFMYm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 08:24:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e+qjQ5GG2TK96kA21df2g2Y0il54AsQVNJL+Xg4wnvF1JnvMtlVrvPzdfTzjVNeYMZMzUZHSKcMB1As9dPVOtFlfU8spziHhcjKfMNxlPM2SmImsSVCZ2k5JNjouHCSLOjiUI5xoSrgj7m1UzQ33M2Hy+JXvPG5cUGqKgxdaOcE=
Message-ID: <4745278c050606052477561c16@mail.gmail.com>
Date: Mon, 6 Jun 2005 08:24:39 -0400
From: Vishal Patil <vishpat@gmail.com>
Reply-To: Vishal Patil <vishpat@gmail.com>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: Memory problems in schedule()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050606023145.GB11352@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4745278c050605180115a70b8d@mail.gmail.com>
	 <20050606023145.GB11352@ccure.user-mode-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff
Please find the answer to questions below,

On 6/5/05, Jeff Dike <jdike@addtoit.com> wrote:
> On Sun, Jun 05, 2005 at 09:01:19PM -0400, Vishal Patil wrote:
> > 1) Whenever I select a process to run using my algorithm the kernel
> > panics with "Segfault with no mm" basically the "mm" field of the
> > task_struct that I selected is empty. I don't understand why this
> > should happen, since I have just added code to select a process and
> > haven't modified any memory related code in the schedule() function.
> 
> Start with a backtrace from the panic and debug it from there.
> 
> > 2) I am able to run the UMLfied kernel under gdb, however the execution
> > never halts even though I set several breakpoints. Also these
> > breakpoints have not been set in interrupt handling code and I have
> > compiled the code with -g option.
> 
> UML and gdb versions?  tt or skas mode?


GNU gdb Red Hat Linux (6.1post-1.20040607.41rh)
uml-patch-2.4.27-1
skas mode.

Thank you.
>                                 Jeff
> 


-- 
A dream is just a dream. A goal is a dream with a plan and a deadline.
