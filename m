Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946750AbWKAKDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946750AbWKAKDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946751AbWKAKDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:03:10 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:13968 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1946750AbWKAKDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:03:09 -0500
Date: Wed, 1 Nov 2006 11:03:07 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       drepper@redhat.com, mingo@elte.hu, tglx@linutronix.de
Subject: Re: [patch 1/1] schedule removal of FUTEX_FD
Message-ID: <20061101100307.GA23629@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, drepper@redhat.com, mingo@elte.hu,
	tglx@linutronix.de
References: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net> <1162343945.14769.16.camel@localhost.localdomain> <20061031172312.79748be5.akpm@osdl.org> <20061101091135.GA22089@outpost.ds9a.nl> <20061101011846.de35bd2a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101011846.de35bd2a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 01:18:46AM -0800, Andrew Morton wrote:
> > I must admit to never having used FUTEX_FD, but the idea of waiting on a
> > FUTEX by way of epoll appealed to me. Should I resort to pipe tricks if I
> > want that ability henceforth?
> 
> I guess so.  Until the grand unified kernel event framework is done.

It might be polite to not entirely remove FUTEX_FD until said 'GUKE'
framework is done.

	Bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
