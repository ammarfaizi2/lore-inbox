Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUG3G2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUG3G2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 02:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUG3G2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 02:28:14 -0400
Received: from peabody.ximian.com ([130.57.169.10]:25789 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267624AbUG3G2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 02:28:05 -0400
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
From: Robert Love <rml@ximian.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040730061005.GF18347@suse.de>
References: <20040728065319.GD11690@suse.de>
	 <20040728145228.GA9316@redhat.com>
	 <20040728145543.GB18846@devserv.devel.redhat.com>
	 <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de>
	 <1091051858.13651.1.camel@camp4.serpentine.com>
	 <20040729084928.GR10377@suse.de> <1091166553.1982.9.camel@localhost>
	 <20040730055333.GC7925@suse.de> <1091167031.1982.13.camel@localhost>
	 <20040730061005.GF18347@suse.de>
Content-Type: text/plain
Date: Fri, 30 Jul 2004 02:28:04 -0400
Message-Id: <1091168884.2009.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 08:10 +0200, Jens Axboe wrote:

> Strange, something else must be accessing the drive at the same time.

Don't see anything.

> If it's just playback, don't bother.

Did not work anyhow.

> So the question is - what else is accessing the drive?

Nothing but the CD player - it is doing CDDB, though, so that is where
the reads are coming from.

It works/fails consistently - for example, I have one CD that never
works and one CD that does, as if the CD is physically damaged.  Works
elsewhere, though.

	Robert Love


