Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTDKAHr (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 20:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264263AbTDKAHr (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 20:07:47 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:15628 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S264129AbTDKAHp (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 20:07:45 -0400
Date: Fri, 11 Apr 2003 10:18:56 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: gandalf@wlug.westbo.se
cc: Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       <cat@zip.com.au>, <linux-kernel@vger.kernel.org>, <akpm@zip.com.au>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: 2.5.67: ext3 and tcp BUG()/oops/error/whatnot?
In-Reply-To: <1050014106.11156.64.camel@tux.rsn.bth.se>
Message-ID: <Mutt.LNX.4.44.0304111009480.18555-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Apr 2003, Martin Josefsson wrote:

> 
> I have a IMO better patch than the one you have and I have tried to get
> Harald to approve one of the patches, I just can't get any kind of
> response from him.
> 
> The new one doesn't leave any dangling pointers around. 
> This is the one I'd prefer, I just need to get it blessed.

Martin, it looks ok to me, and I'm also fine to go with your judgement on
this.

> 
> I'd say we get this to Linus and then Harald can submit a diffrent fix
> if he doesn't approve of this one since it seems it can cause crashes.
> 

Agreed.  The fix can be tested in 2.5 then backported to 2.4 once everyone
is happy.



- James
-- 
James Morris
<jmorris@intercode.com.au>



