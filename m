Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264846AbUEJQKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264846AbUEJQKS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264847AbUEJQKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:10:17 -0400
Received: from nevyn.them.org ([66.93.172.17]:20613 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S264846AbUEJQKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:10:13 -0400
Date: Mon, 10 May 2004 12:10:08 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace in 2.6.5
Message-ID: <20040510161008.GA11114@nevyn.them.org>
Mail-Followup-To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1084203979.1421.1.camel@slack.domain.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084203979.1421.1.camel@slack.domain.invalid>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 12:46:19PM -0300, Fabiano Ramos wrote:
> Hi All.
> 
>      Is ptrace(), in singlestep mode, required to stop after a int 0x80?
>     When tracing a sequence like
> 
> 	mov ...
> 	int 0x80
> 	mov ....
> 
>     ptrace would notify the tracer after the two movs, but not after the
> int 0x80. I want to know if it is a bug or the expected behaviour.

I think it's a bug.

-- 
Daniel Jacobowitz
