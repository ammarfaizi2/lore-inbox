Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265184AbSKFAN5>; Tue, 5 Nov 2002 19:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbSKFAN4>; Tue, 5 Nov 2002 19:13:56 -0500
Received: from smtp3.texas.rr.com ([24.93.36.231]:65527 "EHLO
	txsmtp03.texas.rr.com") by vger.kernel.org with ESMTP
	id <S265184AbSKFANM>; Tue, 5 Nov 2002 19:13:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <kcorry@austin.rr.com>
Reply-To: kcorry@austin.rr.com
To: Mike Diehl <mdiehl@dominion.dyndns.org>, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] EVMS announcement
Date: Tue, 5 Nov 2002 18:36:02 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <02110516191004.07074@boiler> <20021105214012.C2B4651CF@dominion.dyndns.org> <20021105215100.E927E51CF@dominion.dyndns.org>
In-Reply-To: <20021105215100.E927E51CF@dominion.dyndns.org>
MIME-Version: 1.0
Message-Id: <02110518360200.00235@cygnus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tuesday 05 November 2002 15:11, Mike Diehl wrote:
> Well, I'm a bit disapointed.  My experience with LVM has been nothing
> short of disasterous; EVMS looked like a very good alternative to LVM.
> Volume Management is one of the FEW things that Linux lacks that the
> "Big Boys" have.

I'm sorry you feel disappointed. But I assure you that EVMS will continue to 
provide the same experience you have come to expect. All this decision really 
means is that we will be building on a different kernel component, instead of 
providing our own. All of the EVMS tools and libraries will essentially be 
unchanged from the perspective of most users.

> The biggest thing that EVMS had going for it was it's modular design.  As I
> understand it, EVMS could even be used to manage the current MD and LVM
> drivers.  I was looking forward to partition-level encryption, etc.

And we will still maintain that modular design. In fact, we see this as 
making the design even more modular, since it won't have to be tied to a 
single kernel driver. Device mapper can be used for supporting disk 
partitions, LVM, and some other plugins. The MD driver can be used to support 
software RAID. We've even had thoughts about building on the existing loop 
driver in order to provide the partition-level encryption that you mentioned. 
And all of this from a single, unified interface.

> But never mind me.  I'm just a linux user, not a linux developer.

Actually, it *is* the users that we are most concerned with. This is why we 
are going to make such an effort to keep our tools as unchanged as possible. 
But we really do think that this is the best solution in the long term, for 
both the users and the developers.

If you continue to have any concerns about this, please let us know. We will 
do our best to address them and explain any other details about this change 
that you are unsure of.

-Kevin
