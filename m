Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUHSSbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUHSSbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUHSSbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:31:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41634 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267214AbUHSSbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:31:00 -0400
Date: Thu, 19 Aug 2004 14:30:47 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: jmerkey@comcast.net
cc: linux-kernel@vger.kernel.org, <jmerkey@drdos.com>
Subject: Re: kallsyms 2.6.8 address ordering
In-Reply-To: <081920041810.18883.4124ED110002BABC000049C32200748184970A059D0A0306@comcast.net>
Message-ID: <Pine.LNX.4.44.0408191429400.13281-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004 jmerkey@comcast.net wrote:

> kallsyms in 2.6.8 is presenting module symbol tables with out of order
> addresses in 2.6.X.  This makes maintaining a commercial kernel debugger
> for Linux 2.6 kernels nighmareish. 

How hard could it be to sort the table in your debugger ?

> Also, the need to kmalloc name strings (like kdb does) from kallsyms in
> kdbsupport.c while IN THE DEBUGGER makes it impossible to debug large
> portions of the kernel code with kdb, so I have rewritten large sections
> of kallsyms.c to handle all these broken, brain-dead cases in mdb and I
> am not relying much on kdb hooks anymore.
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Sounds like your commercial debugger might just be violating
the GPL ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

