Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266361AbUGOVN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266361AbUGOVN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUGOVN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:13:26 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:55005 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S266361AbUGOVNX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:13:23 -0400
Date: Thu, 15 Jul 2004 14:13:15 -0700
Message-Id: <200407152113.i6FLDFfB013246@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@suse.de>
X-Fcc: ~/Mail/linus
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jparadis@redhat.com, cagney@redhat.com, discuss@x86-64.org
Subject: Re: [PATCH] x86-64 singlestep through sigreturn system call
In-Reply-To: Andi Kleen's message of  Thursday, 15 July 2004 07:46:18 +0200 <20040715074618.4c33bd31.ak@suse.de>
X-Zippy-Says: Hello?  Enema Bondage?  I'm calling because I want to be happy, I guess..
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyways, I don't have any plans to change the 64bit behaviour. gdb will
> have to live with a few minor inconsistencies as price for faster system
> calls. 

My patch doesn't slow anything down beyond one comparison and branch not
taken in the rt_sigreturn system call.  Does that negligible meaning of
"faster" really warrant the inconsistent user behavior?


Thanks,
Roland
