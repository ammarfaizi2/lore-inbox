Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVEaRDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVEaRDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVEaRA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:00:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:29610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261987AbVEaQ5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:57:10 -0400
Date: Tue, 31 May 2005 09:56:40 -0700
From: Chris Wright <chrisw@osdl.org>
To: Greg Stark <gsstark@mit.edu>
Cc: Arjan van de Ven <arjan@infradead.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] prevent NULL mmap in topdown model
Message-ID: <20050531165640.GL27549@shell0.pdx.osdl.net>
References: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0505181535210.18337@ppc970.osdl.org> <Pine.LNX.4.61.0505182224250.29123@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0505181946300.2322@ppc970.osdl.org> <20050519064657.GH23013@shell0.pdx.osdl.net> <1116490511.6027.25.camel@laptopd505.fenrus.org> <87u0klybpq.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0klybpq.fsf@stark.xeocode.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Stark (gsstark@mit.edu) wrote:
> More realistically, iirc either Wine or dosemu, i forget which, actually has
> to map page 0 to work properly.

Yup, this is well-known, and the patch does not effect MAP_FIXED.

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=49a43876b935c811cfd29d8fe998a6912a1cc5c4

thanks,
-chris
