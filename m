Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266834AbSKHRpk>; Fri, 8 Nov 2002 12:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266837AbSKHRpj>; Fri, 8 Nov 2002 12:45:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62474 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266834AbSKHRpj>;
	Fri, 8 Nov 2002 12:45:39 -0500
Date: Fri, 8 Nov 2002 17:52:19 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "'Linus Torvalds '" <torvalds@transmeta.com>,
       "'Jeremy Fitzhardinge '" <jeremy@goop.org>,
       "'William Lee Irwin III '" <wli@holomorphy.com>,
       "'linux-ia64@linuxia64.org '" <linux-ia64@linuxia64.org>,
       "'Linux Kernel List '" <linux-kernel@vger.kernel.org>,
       "'rusty@rustcorp.com.au '" <rusty@rustcorp.com.au>,
       "'dhowells@redhat.com '" <dhowells@redhat.com>,
       "'mingo@elte.hu '" <mingo@elte.hu>
Subject: Re: [Linux-ia64] reader-writer livelock problem
Message-ID: <20021108175219.L12011@parcelfarce.linux.theplanet.co.uk>
References: <3FAD1088D4556046AEC48D80B47B478C0101F4EB@usslc-exch-4.slc.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F4EB@usslc-exch-4.slc.unisys.com>; from kevin.vanmaren@unisys.com on Fri, Nov 08, 2002 at 11:41:57AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 11:41:57AM -0600, Van Maren, Kevin wrote:
> processor to acquire/release the lock once.  So with 32 processors
> contending for the lock, at 1us per cache-cache transfer (picked

if you have 32 processors contending for the same spinlock, you have
bigger problems.

-- 
Revolutions do not require corporate support.
