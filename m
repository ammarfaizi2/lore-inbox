Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291607AbSBMMVj>; Wed, 13 Feb 2002 07:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291611AbSBMMVc>; Wed, 13 Feb 2002 07:21:32 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:14012 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S291607AbSBMMV0>; Wed, 13 Feb 2002 07:21:26 -0500
Date: Wed, 13 Feb 2002 22:18:57 +1100
From: Anton Blanchard <anton@samba.org>
To: David Mosberger <davidm@hpl.hp.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
Message-ID: <20020213111857.GG3886@krispykreme>
In-Reply-To: <15464.34183.282646.869983@napali.hpl.hp.com> <20020211.190449.55725714.davem@redhat.com> <15464.35214.669412.477377@napali.hpl.hp.com> <20020211.192334.123921982.davem@redhat.com> <15464.36074.246502.582895@napali.hpl.hp.com> <20020211212644.A20387@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211212644.A20387@twiddle.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> On another topic, I'm considering having $8 continue to be current
> and using the two-insn stack mask to get current_thread_info and
> measuring the size difference that makes.

This is what paulus has done for ppc32 and what I have shamelessly
copied for ppc64. I was more comfortable doing that then requiring a
load for each use of current.

Anton
