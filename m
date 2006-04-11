Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWDKXGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWDKXGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 19:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWDKXGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 19:06:39 -0400
Received: from [81.2.110.250] ([81.2.110.250]:7580 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751283AbWDKXGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 19:06:38 -0400
Subject: Re: GPL issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ramakanth Gunuganti <rgunugan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060411063127.97362.qmail@web54314.mail.yahoo.com>
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Apr 2006 00:12:19 +0100
Message-Id: <1144797140.29275.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-10 at 23:31 -0700, Ramakanth Gunuganti wrote:
> 1. If an application is built on top of this modified
> kernel, should the application be released under GPL?
> Do system calls provide a bounday for GPL? How does
> this work with LKMs, all the code for LKMs will be
> released but would a userspace application using the
> LKMs choose not to use GPL?

The boundary of the GPL is what is called a "derivative work". This is
the basic concept in law used by copyright and essentially asks "is this
work created in such a way that it is based on the original work in some
meaningful fashion". Its a complex area of law and only a lawyer can
give definitive answers.

The usual case is releasing an application for the Linux OS. It is
unlikely that using system calls could be considered "derivative" and in
case there is doubt the copying file with the Linux kernel specifically
excludes this case because the authors don't want some peculiar legal
interpretation to suddenely try and claim rights on applications running
on Linux.

Your questions really come into the realm of lawyers not programmers
however especially the various fringe areas.

The simple "application for Linux" case is clear. The simple "kernel
modification" case is also clear. In the middle is the vague area that
is for lawyers.


