Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVG1OKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVG1OKK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVG1OAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:00:38 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:25298 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261471AbVG1N7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:59:55 -0400
Date: Thu, 28 Jul 2005 09:59:55 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Raise required gcc version to 3.2 ?
Message-ID: <20050728135955.GC31019@csclub.uwaterloo.ca>
References: <20050728120012.GB3528@stusta.de> <m3hdefxfyn.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hdefxfyn.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 02:39:12PM +0200, Krzysztof Halasa wrote:
> Compilation speed? Don't know, using 3 (4?) years old Athlon 2000
> it's not a problem unless I need full build 30 times a day.
> 
> But people on 266 MHz ARM5 may notice.

Hmm, an a 400Mhz PXA 255 I found using gcc 3.x meant I could use xscale
rather than older optimizations, and the resulting kernel certainly felt
much faster (I never did actually meassure if it was faster or not).
Using gcc 2.95 requried changing the cpu optimization lines in the
kernel.  Of course this was in a kernel patched with the pxa arm patches
so it isn't quite the same as the mainline kernel.  I certainly won't
consider using gcc 2.95 on an arm anymore (although perhaps on older arm
models it does make sense).

I have no idea if it took longer to compile with gcc 3.x, but the result
seemed better to me.  To me performance of the resulting kernel is more
important than performance compiling the kernel.

Of course if you leave the choice as 2.95 and above rather than 3.2 and
above, people can pick whatever they want based on their needs.

Len Sorensen
