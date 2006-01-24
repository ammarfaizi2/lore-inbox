Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWAXWdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWAXWdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWAXWdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:33:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48283 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750790AbWAXWdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:33:43 -0500
Date: Tue, 24 Jan 2006 23:33:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060124223328.GC1602@elf.ucw.cz>
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org> <20060124213010.GA1602@elf.ucw.cz> <20060124135843.739481e7.akpm@osdl.org> <20060124221426.GB1602@elf.ucw.cz> <20060124222044.GG2449@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060124222044.GG2449@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 24-01-06 17:20:44, Dave Jones wrote:
> On Tue, Jan 24, 2006 at 11:14:26PM +0100, Pavel Machek wrote:
> 
>  > suspending programs are quite closely tied to the kernel. I think it
>  > is reasonable to expect users to have matching version of kernel and
>  > userland-swsusp tools
> 
>     _        _    ____  ____   ____  ____ _   _ _   _ _   _ _   _
>    / \      / \  |  _ \|  _ \ / ___|/ ___| | | | | | | | | | | | |
>   / _ \    / _ \ | |_) | |_) | |  _| |  _| |_| | |_| | |_| | |_| |
>  / ___ \  / ___ \|  _ <|  _ <| |_| | |_| |  _  |  _  |  _  |  _  |
> /_/   \_\/_/   \_\_| \_\_| \_\\____|\____|_| |_|_| |_|_| |_|_| |_|
> 
> Someone please stop this madness..

Nice ascii art :-).

We'll of course try to get the interface right at the first
try. OTOH... if wrong interface is in kernel for a month, I do not
think it is reasonable to keep supporting that wrong interface for a
year before it can be removed. One month of warning should be fair in
such case...
								Pavel

-- 
Thanks, Sharp!
