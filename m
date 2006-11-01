Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946711AbWKAJLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946711AbWKAJLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946716AbWKAJLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:11:40 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:56719 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1946711AbWKAJLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:11:39 -0500
Date: Wed, 1 Nov 2006 10:11:35 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       drepper@redhat.com, mingo@elte.hu, tglx@linutronix.de
Subject: Re: [patch 1/1] schedule removal of FUTEX_FD
Message-ID: <20061101091135.GA22089@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, drepper@redhat.com, mingo@elte.hu,
	tglx@linutronix.de
References: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net> <1162343945.14769.16.camel@localhost.localdomain> <20061031172312.79748be5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031172312.79748be5.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 05:23:12PM -0800, Andrew Morton wrote:
> > Now, I realize with some dismay that simplicity is no longer a futex
> > feature, but it might be worth considering?
> 
> Sure.  Perhaps we could accelerate the removal schedule if we want to do
> this.  Let's see how many 2.6.19 users squeak first.

I must admit to never having used FUTEX_FD, but the idea of waiting on a
FUTEX by way of epoll appealed to me. Should I resort to pipe tricks if I
want that ability henceforth?

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
