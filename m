Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUHaQxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUHaQxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUHaQxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:53:13 -0400
Received: from peabody.ximian.com ([130.57.169.10]:4539 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264377AbUHaQxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:53:09 -0400
Subject: Re: [ANNOUNCE] Kernel Generalized Event Management
From: Robert Love <rml@ximian.com>
To: Bob Bennett <Robert.Bennett2@ca.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, kgem-devel@lists.sourceforge.net
In-Reply-To: <1093966183.22744.125.camel@benro02lx.ca.com>
References: <Pine.LNX.4.58.0408301738310.22919@benro02lx.ca.com>
	 <20040830153942.C1973@build.pdx.osdl.net>
	 <1093966183.22744.125.camel@benro02lx.ca.com>
Content-Type: text/plain
Date: Tue, 31 Aug 2004 12:52:36 -0400
Message-Id: <1093971158.4815.2.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 11:29 -0400, Bob Bennett wrote:

> It appears that Robert Love's Kernel Events Layer project is attempting
> to address a lot of these event management issues.  An alternative is to
> build upon this project to support synchronous event handling as well as
> the event broadcasting that it performs now. 

With the Kernel Events Layer, we are not looking to provide synchronous
notification or a method for user-space to affect kernel behavior.

The Kernel Events Layer in its current incarnation (which I need to
rediff and post) is a general sysfs change notifier.  And it is just a
layer netlink, at the end of the day.

	Robert Love


