Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVA2SPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVA2SPp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 13:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVA2SPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 13:15:45 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:3090 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261384AbVA2SPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 13:15:31 -0500
Date: Sat, 29 Jan 2005 19:15:18 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Robert Love <rml@novell.com>
Cc: Rodrigo Ramos <rodrigo.ramos@triforsec.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: system calls
Message-ID: <20050129181518.GG6010@pclin040.win.tue.nl>
References: <1107006832.2732.35.camel@ZeroOne> <1107020858.11159.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107020858.11159.15.camel@localhost>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 12:47:38PM -0500, Robert Love wrote:

> System calls are prefixed by "sys_".  Thus, read(2) is implemented in
> the kernel as sys_read().

Now that you say this - of course you know that the actual
situation is much more messy. Sometimes I wonder whether
it would be useful to make such a statement more true
and for example change sys_olduname, sys_uname, sys_newuname
into sys_oldolduname, sys_olduname, sys_uname.

Andries
