Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbVIHPUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbVIHPUd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbVIHPUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:20:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21943 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932684AbVIHPUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:20:32 -0400
Date: Thu, 8 Sep 2005 16:20:30 +0100
From: viro@ZenIV.linux.org.uk
To: Christoph Hellwig <hch@infradead.org>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmmod notifier chain
Message-ID: <20050908152030.GA9623@ZenIV.linux.org.uk>
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com> <20050908151624.GA11067@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908151624.GA11067@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 04:16:24PM +0100, Christoph Hellwig wrote:
> On Thu, Sep 08, 2005 at 05:03:58PM +0200, Jan Beulich wrote:
> > (Note: Patch also attached because the inline version is certain to get
> > line wrapped.)
> > 
> > Debugging and maintenance support code occasionally needs to know not
> > only of module insertions, but also modulke removals. This adds a
> > notifier
> > chain for this purpose.
> 
> I don't think this should be exported, _GPL if at all.  And it certainly
> shouldn't go in without an actual user.

... or at least a description that would go well beyond "occasionally needs
to know".  Details, please.
