Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWHVO7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWHVO7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWHVO7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:59:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:61347 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932292AbWHVO7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:59:38 -0400
From: Andi Kleen <ak@suse.de>
To: Ian Campbell <Ian.Campbell@xensource.com>
Subject: Re: [PATCH 1 of 1] x86_64: Put .note.* sections into a PT_NOTE segment in vmlinux II
Date: Tue, 22 Aug 2006 16:59:18 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@xensource.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization <virtualization@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
References: <1156256777.5091.93.camel@localhost.localdomain>
In-Reply-To: <1156256777.5091.93.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608221659.18896.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 August 2006 16:26, Ian Campbell wrote:
> This patch updates x86_64 linker script to pack any .note.* sections
> into a PT_NOTE segment in the output file.


Sorry I tried to apply it, but at least 2.6.18rc4 mainline (which my tree
is based on) doesn't have a NOTES macro so it doesn't link

I dropped the NOTES addition for now, presumably it will need to be readded
later.

-Andi
