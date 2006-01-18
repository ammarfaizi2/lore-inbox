Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWARXOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWARXOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWARXOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:14:40 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54509 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161046AbWARXOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:14:39 -0500
Subject: Re: 2.6.16-rc1-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Reuben Farrelly <reuben-lkml@reub.net>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       arjan@infradead.org
In-Reply-To: <20060118190926.GB316@redhat.com>
References: <20060118005053.118f1abc.akpm@osdl.org>
	 <43CE2210.60509@reub.net> <20060118032716.7f0d9b6a.akpm@osdl.org>
	 <20060118190926.GB316@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 23:13:41 +0000
Message-Id: <1137626021.1760.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-18 at 14:09 -0500, Dave Jones wrote:
> On Wed, Jan 18, 2006 at 03:27:16AM -0800, Andrew Morton wrote:
> 
>  > Well yes, that code is kfree()ing a locked mutex.  It's somewhat weird to
>  > take a lock on a still-private object but whatever.  The code's legal
>  > enough.
>  > 

If someone else can be waiting on it then it doesn't look legal ?

