Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131393AbRBWScV>; Fri, 23 Feb 2001 13:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131653AbRBWScL>; Fri, 23 Feb 2001 13:32:11 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:55300 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131190AbRBWSb4>; Fri, 23 Feb 2001 13:31:56 -0500
Date: Fri, 23 Feb 2001 13:31:24 -0500
From: Chris Mason <mason@suse.com>
To: patrick@spacesurfer.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfs problem
Message-ID: <462990000.982953084@tiny>
In-Reply-To: <3A9697EC.892E4230@spacesurfer.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, February 23, 2001 05:03:40 PM +0000 Patrick Mackinlay
<patrick@spacesurfer.com> wrote:

> When 2.4.1 was released I reported a kernel oops with reiserfs, I got no
> response.

Hmmm, don't seem to have any other reiserfs mail from you.  Sorry I missed
it.

[ ...]
> 
> kernel oops report:
>>> EIP; d2cf9db8 <[reiserfs]create_virtual_node+298/490>   <=====

We've had a half dozen or so reports so far of this, almost every time it
has been resolved as a compiler issue, usually an unpatched gcc 2.96.  One
user was using 2.95.3, but did not report back if switching to 2.95.2 or
egcs fixed the oops.

Anyway, which compiler did you use to compile the kernel?

-chris

