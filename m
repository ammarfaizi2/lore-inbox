Return-Path: <linux-kernel-owner+w=401wt.eu-S933230AbWLaVsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230AbWLaVsU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 16:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933223AbWLaVsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 16:48:20 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:51600 "EHLO
	liaag2ad.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933234AbWLaVsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 16:48:20 -0500
Date: Sun, 31 Dec 2006 16:43:11 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.19.1
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Message-ID: <200612311646_MC3-1-D6DD-9566@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200612301829.15980.s0348365@sms.ed.ac.uk>

On Sat, 30 Dec 2006 18:29:15 +0000, Alistair John Strachan wrote:

> > Can you post disassembly of pipe_poll() for both the one that crashes
> > and the one that doesn't?  Use 'objdump -D -r fs/pipe.o' so we get the
> > relocation info and post just the one function from each for now.
> 
> Sure, no problem:
> 
> http://devzero.co.uk/~alistair/2.6.19-via-c3-pipe_poll/
> 
> Both use identical configs, neither are optimised for size. The config is 
> available from the same location.

Those were compiled without frame pointers.  Can you post them compiled
with frame pointers so they match your original bug report? And confirm
that pipe_poll() is still at 0xc0156ec0 in vmlinux?

-- 
MBTI: IXTP

