Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbUKCA4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUKCA4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbUKCAz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:55:58 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:57539 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261265AbUKCAyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 19:54:38 -0500
Date: Wed, 3 Nov 2004 01:54:15 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041103005415.GZ3571@dualathlon.random>
References: <4187FA6D.3070604@us.ibm.com> <20041102220720.GV3571@dualathlon.random> <4188086F.8010005@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4188086F.8010005@us.ibm.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 02:21:35PM -0800, Dave Hansen wrote:
> OK, good to know.  But, for now, can we pull this out of -mm?  Or, at 

I doubt it's a good idea unless 1) you want the silent memleak back or
2) you found something wrong in the fix itself.
