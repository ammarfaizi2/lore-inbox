Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWCEQVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWCEQVz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 11:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWCEQVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 11:21:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5052 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932198AbWCEQVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 11:21:55 -0500
To: Greg KH <gregkh@suse.de>
Cc: Nicholas Miell <nmiell@comcast.net>, Greg KH <greg@kroah.com>,
       "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
References: <20060227190150.GA9121@kroah.com>
	<20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de>
	<Pine.LNX.4.64.0602271216340.22647@g5.osdl.org>
	<20060227234525.GA21694@suse.de> <20060228063207.GA12502@thunk.org>
	<20060301003452.GG23716@kroah.com> <1141175870.2989.17.camel@entropy>
	<20060302042455.GB10464@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 05 Mar 2006 09:17:59 -0700
In-Reply-To: <20060302042455.GB10464@suse.de> (Greg KH's message of "Wed, 1
 Mar 2006 20:24:55 -0800")
Message-ID: <m1fylwc1c8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> writes:

> Even Solaris documents the maturity level of its interfaces, that is all
> I am trying to do here.  I'm not trying to pass judgement on the quality
> of any of these interfaces.

So if we go down this path can we make this functional Documentation?

In particular can we have per process/per interface kinds of flags that
allow access to experimental subsystems?

If the developer has to jump through an extra hoop to use an interface
we have clearly documented this is unsupported and will change in the
future.  Anything else can be easy to miss.

Eric
