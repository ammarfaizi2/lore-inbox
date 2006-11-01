Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946718AbWKAJTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946718AbWKAJTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946720AbWKAJTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:19:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59877 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946718AbWKAJTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:19:22 -0500
Date: Wed, 1 Nov 2006 01:18:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       drepper@redhat.com, mingo@elte.hu, tglx@linutronix.de
Subject: Re: [patch 1/1] schedule removal of FUTEX_FD
Message-Id: <20061101011846.de35bd2a.akpm@osdl.org>
In-Reply-To: <20061101091135.GA22089@outpost.ds9a.nl>
References: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
	<1162343945.14769.16.camel@localhost.localdomain>
	<20061031172312.79748be5.akpm@osdl.org>
	<20061101091135.GA22089@outpost.ds9a.nl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 10:11:35 +0100
bert hubert <bert.hubert@netherlabs.nl> wrote:

> On Tue, Oct 31, 2006 at 05:23:12PM -0800, Andrew Morton wrote:
> > > Now, I realize with some dismay that simplicity is no longer a futex
> > > feature, but it might be worth considering?
> > 
> > Sure.  Perhaps we could accelerate the removal schedule if we want to do
> > this.  Let's see how many 2.6.19 users squeak first.
> 
> I must admit to never having used FUTEX_FD, but the idea of waiting on a
> FUTEX by way of epoll appealed to me. Should I resort to pipe tricks if I
> want that ability henceforth?
> 

I guess so.  Until the grand unified kernel event framework is done.
