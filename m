Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUBLWDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266632AbUBLWDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:03:51 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:59061 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266631AbUBLWDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:03:49 -0500
Date: Thu, 12 Feb 2004 22:01:32 +0000
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] bogus __KERNEL_SYSCALLS__ usage
Message-ID: <20040212220132.GY12634@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org, "Randy.Dunlap" <rddunlap@osdl.org>
References: <20040212162856.GU12634@redhat.com> <20040212134342.0874290a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212134342.0874290a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 01:43:42PM -0800, Andrew Morton wrote:

 > > I just did a mini-audit of users of __KERNEL_SYSCALLS and turned
 > > up a bunch of uglies. The patch below is the easy ones
 > 
 > OK.  But Randy is currently beavering away at the astonishing number of
 > open-coded sys_foo() declarations, and that work has a significant
 > intersection with yours.
 > 
 > So can we please park this for now, pick it up again when Randy has
 > finished?

Yeah, that's fine with me, as is Randy hoovering this up and rolling
it in with his stuff if he wants..

		Dave

