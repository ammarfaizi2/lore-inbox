Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbUADIkK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 03:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUADIkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 03:40:09 -0500
Received: from waste.org ([209.173.204.2]:20700 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264473AbUADIkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 03:40:06 -0500
Date: Sun, 4 Jan 2004 02:40:05 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny1 tree for small systems
Message-ID: <20040104084005.GU18208@waste.org>
References: <20040103030814.GG18208@waste.org> <m13cawi2h8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13cawi2h8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 12:42:43AM -0700, Eric W. Biederman wrote:
> Matt Mackall <mpm@selenic.com> writes:
> 
> > Contributions and suggestions are encouraged. In particular, it would
> > be helpful if people with non-x86 hardware could take a stab at
> > extending some of the stuff that's currently only been done for X86 to
> > other architectures.
> 
> I just tried a kernel build with as much as possible turned off.  This
> uncovered a couple of bugs, which I fixed with the attached diff.  But
> it looks like there finally is a light at the end of the rainbow.

Thanks. I actually cleaned up all this stuff earlier today, will
probably do another release shortly.
 
> 220K compressed and 371K uncompressed.  This is a serious reduction from
> previous versions.  There is still a huge amount of code I can't compile
> out but this is certainly progress.  Thank you.

Suggestions? I'm rapidly exhausting a lot of the obvious candidates.
My target build at the moment is ide + ext2 + proc + ipv4 + console, and
that's currently at around 800K uncompressed, booting in a little less
than 2.5MB. Hoping to get that under 2.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
