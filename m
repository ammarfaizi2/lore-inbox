Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTLGJHb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 04:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTLGJHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 04:07:31 -0500
Received: from holomorphy.com ([199.26.172.102]:29144 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264340AbTLGJHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 04:07:30 -0500
Date: Sun, 7 Dec 2003 01:07:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mark Symonds <mark@symonds.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 hard lock, 100% reproducible.
Message-ID: <20031207090723.GV8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mark Symonds <mark@symonds.net>, linux-kernel@vger.kernel.org
References: <20031207065017.48483.qmail@web40506.mail.yahoo.com> <20031207065538.GT8039@holomorphy.com> <046a01c3bca1$267ba5e0$7a01a8c0@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <046a01c3bca1$267ba5e0$7a01a8c0@gandalf>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Compile your kernel with debug symbols and use addr2line on that EIP.

On Sun, Dec 07, 2003 at 01:04:41AM -0800, Mark Symonds wrote:
> I'm not a kernel developer, but here goes: 
> puggy:/usr/src/linux/2.4.23# addr2line c02363dd -e vmlinux
> ??:0
> puggy:/usr/src/linux/2.4.23#
> That doesn't look right.  I compiled with kernel debugging 
> enabled only; none of the other options.  Should I enable 
> others/all of them?  

For 2.4 you have to add -g to the compile options by hand in the kernel
makefile.


-- wli
