Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267211AbUBSD4w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 22:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267207AbUBSD4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 22:56:51 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:27844 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267211AbUBSD4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 22:56:50 -0500
Date: Thu, 19 Feb 2004 03:54:07 +0000
From: Dave Jones <davej@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: userspace mptable parsing broken in 2.6
Message-ID: <20040219035406.GH6242@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040211121350.GK12634@redhat.com> <402BD3C4.1010905@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402BD3C4.1010905@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 08:28:04PM +0100, Manfred Spraul wrote:

 > >Reading from some parts of /dev/mem is still broken in 2.6.3rc2,
 > >which breaks at least x86info.
 > >
 > >Manfred, in the end of the last thread on this at..
 > >http://www.ussg.iu.edu/hypermail/linux/kernel/0311.1/0373.html
 > >you mentioned you were going to add some code to /dev/mem for the
 > >DEBUG_PAGEALLOC case. Did you get anywhere with that?
 > >
 > Sorry, I forgot about the issue.
 > What about the attached patch?

Seems to do the right thing here.

		Dave

