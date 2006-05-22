Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWEVF73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWEVF73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 01:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWEVF73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 01:59:29 -0400
Received: from dd6424.kasserver.com ([85.13.131.51]:38294 "EHLO
	dd6424.kasserver.com") by vger.kernel.org with ESMTP
	id S932132AbWEVF72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 01:59:28 -0400
Message-ID: <4471533C.2030605@feuerpokemon.de>
Date: Mon, 22 May 2006 07:59:24 +0200
From: dragoran <dragoran@feuerpokemon.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       dragoran <dragoran@feuerpokemon.de>, linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
References: <44702650.30507@feuerpokemon.de> <200605220019.08902.ak@suse.de> <20060521222831.GP8250@redhat.com> <200605220037.58286.ak@suse.de> <20060521234821.GQ8250@redhat.com>
In-Reply-To: <20060521234821.GQ8250@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, May 22, 2006 at 12:37:57AM +0200, Andi Kleen wrote:
>  > On Monday 22 May 2006 00:28, Dave Jones wrote:
>  > > On Mon, May 22, 2006 at 12:19:08AM +0200, Andi Kleen wrote:
>  > > 
>  > >  > >  > You make a good point.  In fact, given it's unthrottled, someone
>  > >  > >  > with too much time on their hands could easily fill up a /var
>  > >  > >  > just by calling unimplemented syscalls this way.
>  > >  > 
>  > >  > I never bought this argument because there are tons of printks in the kernel
>  > >  > that can be triggered by everybody.
>  > > 
>  > > Then they should also be either rate limited, or removed.
>  > 
>  > Yes let's remove all that kernel debugging support. It is totally useless
>  > for most users, isn't it?
>
> If a regular user can trip up debugging printks, yes, lets remove it.
> Examples ?
>
> 		Dave
>
>   
allmost all selinux messages.
