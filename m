Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVBZOnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVBZOnq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 09:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVBZOnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 09:43:46 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:48819 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261155AbVBZOnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 09:43:45 -0500
Subject: Re: System call problem
From: Steven Rostedt <srostedt@stny.rr.com>
Reply-To: rostedt@goodmis.org
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42208509.3080201@euroweb.net.mt>
References: <42208509.3080201@euroweb.net.mt>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 26 Feb 2005 09:43:36 -0500
Message-Id: <1109429016.1452.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-26 at 15:17 +0100, Josef E. Galea wrote:

> I compiled and booted the kernel and am trying to build a user space 
> application that uses my system call, however gcc is returning this error:
> /tmp/cc4zgzUr.o(.text+0x4e): In functiono `get_rmt_paging':
> : undefined reference to `errno'
> 

Where you defined your system call in the user space program (ie. where
you declared your _syscall macro), did you also include <errno.h>?

-- Steve


