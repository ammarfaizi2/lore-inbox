Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbUFFHAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUFFHAr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 03:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUFFHAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 03:00:47 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3200 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262963AbUFFHAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 03:00:46 -0400
Date: Sun, 6 Jun 2004 08:08:25 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200406060708.i5678PW4000272@81-2-122-30.bradfords.org.uk>
To: Rik van Riel <riel@redhat.com>,
       =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVuIC8gVHJvbmlj?= <tronic2@sci.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0406051935380.29273-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0406051935380.29273-100000@chimarrao.boston.redhat.com>
Subject: Re: Some thoughts about cache and swap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Rik van Riel <riel@redhat.com>:
> On Sat, 5 Jun 2004, [UTF-8] Lasse K=C3=A4rkk=C3=A4inen / Tronic wrote:
> 
> > In order to make better use of the limited cache space, the following
> > methods could be used:
> 
> 	[snip magic piled on more magic]
> 
> I wonder if we should just bite the bullet and implement
> LIRS, ARC or CART for Linux.  These replacement algorithms
> should pretty much detect by themselves which pages are
> being used again (within a reasonable time) and which pages
> aren't.

Is the current system really bad enough to make it worthwhile, though?

Is there really much performance to be gained from tuning the 'limited' cache
space, or will it just hurt as many or more systems than it helps?

John.
