Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264644AbUD2VIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264644AbUD2VIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264751AbUD2Uqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:46:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:10704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264644AbUD2UnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:43:21 -0400
Date: Thu, 29 Apr 2004 13:45:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc2-mm2
Message-Id: <20040429134546.5e9515d8.akpm@osdl.org>
In-Reply-To: <20040429184126.GB783@holomorphy.com>
References: <20040426013944.49a105a8.akpm@osdl.org>
	<20040429184126.GB783@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Mon, Apr 26, 2004 at 01:39:44AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/
> > - Largeish reiserfs feature update.  The biggest change is probably the new
> >   block allocation algorithm.  See the changelog inside
> >   reiserfs-group-alloc-9.patch for details.
> > - Added the ia64 CPU hotplug support patch
> > - More work against the ext3 block allocator.
> > - Several more framebuffer driver update, some quite substantial.
> > - Lots of fixes, mostly minor.
> 
> I missed -mm1; both this and -mm1 appear to be unable to detect Adaptec
> 39160 HBA's. I'm in the midst of bisecting this. Thus far I have the
> last known-working as virgin 2.6.6-rc2, and first known broken is patch
> #36 out of 308 i.e. it's probably in one of the external bk trees or
> linus.patch, though linus.patch doesn't seem to have anything related.

bk-scsi.patch will be the one to try.
