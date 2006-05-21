Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWEUXsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWEUXsk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 19:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWEUXsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 19:48:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9947 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964943AbWEUXsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 19:48:40 -0400
Date: Sun, 21 May 2006 19:48:21 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Ulrich Drepper <drepper@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       dragoran <dragoran@feuerpokemon.de>, linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
Message-ID: <20060521234821.GQ8250@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Ulrich Drepper <drepper@gmail.com>, Chris Wedgwood <cw@f00f.org>,
	dragoran <dragoran@feuerpokemon.de>, linux-kernel@vger.kernel.org
References: <44702650.30507@feuerpokemon.de> <200605220019.08902.ak@suse.de> <20060521222831.GP8250@redhat.com> <200605220037.58286.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605220037.58286.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 12:37:57AM +0200, Andi Kleen wrote:
 > On Monday 22 May 2006 00:28, Dave Jones wrote:
 > > On Mon, May 22, 2006 at 12:19:08AM +0200, Andi Kleen wrote:
 > > 
 > >  > >  > You make a good point.  In fact, given it's unthrottled, someone
 > >  > >  > with too much time on their hands could easily fill up a /var
 > >  > >  > just by calling unimplemented syscalls this way.
 > >  > 
 > >  > I never bought this argument because there are tons of printks in the kernel
 > >  > that can be triggered by everybody.
 > > 
 > > Then they should also be either rate limited, or removed.
 > 
 > Yes let's remove all that kernel debugging support. It is totally useless
 > for most users, isn't it?

If a regular user can trip up debugging printks, yes, lets remove it.
Examples ?

		Dave

-- 
http://www.codemonkey.org.uk
