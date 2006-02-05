Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbWBELyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWBELyr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWBELyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:54:47 -0500
Received: from gold.veritas.com ([143.127.12.110]:25000 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751730AbWBELyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:54:46 -0500
Date: Sun, 5 Feb 2006 11:55:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Gleb Natapov <gleb@minantech.com>
cc: yipee <yipeeyipeeyipeeyipee@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: changing physical page
In-Reply-To: <20060205070027.GA11558@minantech.com>
Message-ID: <Pine.LNX.4.61.0602051154180.5706@goblin.wat.veritas.com>
References: <loom.20060202T160457-366@post.gmane.org>
 <Pine.LNX.4.61.0602021711110.8796@goblin.wat.veritas.com>
 <loom.20060204T152816-726@post.gmane.org> <Pine.LNX.4.61.0602041518230.8867@goblin.wat.veritas.com>
 <20060205070027.GA11558@minantech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 05 Feb 2006 11:54:42.0008 (UTC) FILETIME=[F309A580:01C62A4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2006, Gleb Natapov wrote:
> On Sat, Feb 04, 2006 at 03:20:00PM +0000, Hugh Dickins wrote:
> > On Sat, 4 Feb 2006, yipee wrote:
> > > Hugh Dickins <hugh <at> veritas.com> writes:
> > > > I'll assume that when you say "page owned by a user program", you're
> > > > meaning a private page, not a shared file page mapped into the program.
> > > > 
> > > > If you're asking about what currently happens, the answer is "No".
> > > > 
> > > > If you're asking about what you can assume, the answer is "Yes".
> > > 
> > > So you are saying that the current kernel doesn't move these kind of pages?
> > 
> > If you don't have swap (one of the conditions you gave), yes.
> > 
> And what if application forks and writes to the private page? Kernel
> actually memcpy the page to another location.

Good point.
Hugh
