Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292762AbSB0RbO>; Wed, 27 Feb 2002 12:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292841AbSB0Ra7>; Wed, 27 Feb 2002 12:30:59 -0500
Received: from www.transvirtual.com ([206.14.214.140]:63756 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S292838AbSB0Rak>; Wed, 27 Feb 2002 12:30:40 -0500
Date: Wed, 27 Feb 2002 09:30:18 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Dave Jones <davej@suse.de>
cc: Ben Clifford <benc@hawaga.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj2 oops
In-Reply-To: <20020227172030.F16565@suse.de>
Message-ID: <Pine.LNX.4.10.10202270911080.31753-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Feb 27, 2002 at 08:13:49AM -0800, Ben Clifford wrote:
>  > >>EIP; c01883c4 <vc_allocate+e4/f0>   <=====
>  > Trace; c0189059 <con_open+19/70>
>  > Trace; c017f726 <tty_open+216/3c0>
> 
>  Yup, something not quite right with the last set of James' console
>  changes by the looks. I already bounced him a copy of a similar oops.
> 
>  For now, you could try backing out the console-preempt.diff patch
>  from http://www.codemonkey.org.uk/patches/merged/2.5.5/dj2/

Ah the joy of incremental changes. You always miss something. This is the
next set of patches. I have it running on my current system and I looked
for Oops but didn't see any. Let me know if this doesn't work. Apply the
below patch.

http://www.transvirtual.com/~jsimmons/console/console_8.diff






