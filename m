Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318439AbSGZTH4>; Fri, 26 Jul 2002 15:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318440AbSGZTH4>; Fri, 26 Jul 2002 15:07:56 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:13061 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318439AbSGZTHz>; Fri, 26 Jul 2002 15:07:55 -0400
Date: Fri, 26 Jul 2002 16:10:00 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Robert Love <rml@tech9.net>
cc: Russell Lewis <spamhole-2001-07-16@deming-os.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
In-Reply-To: <1027707680.2442.33.camel@sinai>
Message-ID: <Pine.LNX.4.44L.0207261608320.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jul 2002, Robert Love wrote:
> On Fri, 2002-07-26 at 10:59, Russell Lewis wrote:
>
> > I have spent some time working on AIX, which pages its kernel memory.
> >  It pins the interrupt handler functions, and any data that they access,
> > but does not pin the other code.
> >
> > I'm looking for links as to why (unless I'm mistaken) Linux doesn't do
> > this, so I can better understand the system.
>
> Better question is, why would we have page-able kernel memory?

We don't want to have generic page-able kernel memory.

However, it might be useful to be able to reclaim or page
out data structures that might otherwise gobble up all of
RAM and crash the machine, say page tables.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

