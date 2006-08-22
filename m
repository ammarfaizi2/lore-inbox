Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWHVP0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWHVP0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWHVP0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:26:47 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:21676 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S932317AbWHVP0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:26:47 -0400
Subject: Re: [PATCH 1 of 1] x86_64: Put .note.* sections into a PT_NOTE
	segment in vmlinux II
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@XenSource.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@XenSource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization <virtualization@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <200608221659.18896.ak@suse.de>
References: <1156256777.5091.93.camel@localhost.localdomain>
	 <200608221659.18896.ak@suse.de>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 16:26:48 +0100
Message-Id: <1156260408.5091.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Aug 2006 15:28:33.0588 (UTC) FILETIME=[A10BDF40:01C6C5FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 16:59 +0200, Andi Kleen wrote:
> On Tuesday 22 August 2006 16:26, Ian Campbell wrote:
> > This patch updates x86_64 linker script to pack any .note.* sections
> > into a PT_NOTE segment in the output file.

> Sorry I tried to apply it, but at least 2.6.18rc4 mainline (which my tree
> is based on) doesn't have a NOTES macro so it doesn't link
> 
> I dropped the NOTES addition for now, presumably it will need to be readded
> later.

Sorry, I should have been clearer about the dependency on the i386 patch
which is currently in -mm. 

Ian.


