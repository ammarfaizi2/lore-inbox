Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265618AbTIDWTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265615AbTIDWTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:19:38 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:9613 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S265618AbTIDWTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:19:33 -0400
Date: Thu, 4 Sep 2003 23:19:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: James Clark <jimwclark@ntlworld.com>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Message-ID: <20030904221924.GK31590@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309041628380.14715-100000@chimarrao.boston.redhat.com> <200309042212.25052.jimwclark@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309042212.25052.jimwclark@ntlworld.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Clark wrote:
> Why would binary drivers be any harder to debug than the existing binary 
> kernel. If you want to debug something use the source code. My proposal 
> doesn't remove the need for quality public source code but it does isolate 
> the kernel components and allow for 'plugin' use on different kernels both 
> old and new.

Your first statement doesn't make sense.

We don't debug binary kernels by themselves - we debug them with source.

Binary drivers that come without source are almost impossible to debug.

If we can't debug the drivers, we'll soon have a Linux community
that's full of broken drivers.

If broken binary-only drivers becomes significant for many users,
Linux will become much less fun - and it may harm its adoption and
improvment.

Some would say the problem of binary-only drivers is already
significantly harming the development process: think of the people
running 2.4-only drivers who cannot be involved in 2.6 testing or
development.

Also the rate at which new open source drivers are produced will
decrease, because there will be less useful source for authors to
learn from.

-- Jamie
