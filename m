Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTLKIm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTLKIm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:42:26 -0500
Received: from main.gmane.org ([80.91.224.249]:43659 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264478AbTLKImY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:42:24 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Thu, 11 Dec 2003 09:42:21 +0100
Message-ID: <yw1xoeufhhjm.fsf@kth.se>
References: <3FD78645.9090300@wmich.edu> <Pine.LNX.4.44.0312110046350.3331-100000@gaia.cela.pl>
 <20031211015348.GA23489@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:gAD+ZyTNSJRSjJq4uxYaO1g6AP0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke <mark@mark.mielke.cc> writes:

> I was under the impression, that on the x86 processors, it is not
> possible to have more than ~640Kb of 'unswappable'
> memory. Everything else *is* swappable.

Swappable or not doesn't depend on physical memory address.  It
depends on whether the kernel memory management allows it or not.  No
Linux kernels to date will swap out kernel memory.  The swappability
of a page is determined by some flags when it is allocated.

> Perhaps somebody with understanding could enlighten us on this point?
>
> Is kernel code swappable if compiled in statically? I have assumed
> that it is.

That's not the way it works.

-- 
Måns Rullgård
mru@kth.se

