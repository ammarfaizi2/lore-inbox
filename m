Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265554AbUEZMeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265554AbUEZMeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265552AbUEZMeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:34:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51885 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265555AbUEZMeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:34:06 -0400
Date: Wed, 26 May 2004 08:30:59 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Buddy Lumpkin <b.lumpkin@comcast.net>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
In-Reply-To: <200405261341.10384.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0405260828180.30062-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004, Denis Vlasenko wrote:

> No. Unfortunately, userspace programs grow in size as fast
> as your RAM. Because typically developers do not think
> about size of their program until it starts to outgrow
> their RAM.

It's worse than that.  Way worse.

The speed of hard disks doesn't grow anywhere near as
fast as the size of memory and applications. This means
that over the last years, swapping in any particular
application has gotten SLOWER than it used to be ...

This means that even though the VM is way smarter than
it used to be, the visibility of any wrong decision has
increased.

I wonder if there's a way we could change the VM so it
could recover faster from any mistakes it made, instead
of trying to prevent it from making any mistakes (those
will happen anyway, the VM can't predict the future).

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

