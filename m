Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbVIBX6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbVIBX6f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbVIBX6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:58:34 -0400
Received: from codepoet.org ([166.70.99.138]:20901 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1751383AbVIBX6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:58:34 -0400
Date: Fri, 2 Sep 2005 17:58:33 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Message-ID: <20050902235833.GA28238@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Kyle Moffett <mrmacman_g4@mac.com>,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 02, 2005 at 04:51:49PM -0400, Kyle Moffett wrote:
> On Sep 2, 2005, at 09:41:09, Erik Andersen wrote:
> >Have you seen the linux-libc-headers:
> >    http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
> >which, while not an official part of the kernel, do a pretty
> >good job...
> 
> Well, the eventual goal of this project would be to eliminate the
> need for linux-libc-headers by making that task trivial (IE: Just copy
> the kcore/ and kabi/ (or whatever they get called) directories into
> /usr/include.

<uClibc maintainer hat on>
That would be wonderful.
</off>

It would be especially nice if everything targeting user space
were to use only all the nice standard ISO C99 types as defined
in include/stdint.h such as uint32_t and friends...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
