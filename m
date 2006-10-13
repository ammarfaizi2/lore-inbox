Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWJMR7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWJMR7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWJMR7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:59:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751398AbWJMR7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:59:35 -0400
Date: Fri, 13 Oct 2006 10:59:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.6.19-rc2
In-Reply-To: <200610131840.28411.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0610131057130.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
 <200610131840.28411.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Oct 2006, Alistair John Strachan wrote:
> 
> Does anybody know what's up with the git server? Hopefully it's just my 
> connection...

It's likely either
 - a mirroring issue (the git.kernel.org server is _not_ the main one I 
   push to, so it can take a while, and if some objects haven't made it, 
   the upload side will exit because the repository isn't "valid" until 
   the full mirror has happened)
 - too many clients trying at the same time

In this case, I suspect the latter.

		Linus
