Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269580AbRHAA4n>; Tue, 31 Jul 2001 20:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269586AbRHAA4d>; Tue, 31 Jul 2001 20:56:33 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:30471 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269580AbRHAA4X>; Tue, 31 Jul 2001 20:56:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] using writepage to start io
Date: Wed, 1 Aug 2001 03:01:17 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-mm@kvack.org, torvalds@transmeta.com
In-Reply-To: <233400000.996606471@tiny>
In-Reply-To: <233400000.996606471@tiny>
MIME-Version: 1.0
Message-Id: <01080103011705.00303@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi, Chris

On Tuesday 31 July 2001 21:07, Chris Mason wrote:
> I had to keep some of the flush_dirty_buffer calls as page_launder
> wasn't triggering enough i/o on its own.  What I'd like to do now is
> experiment with changing bdflush to only write pages off the inactive
> dirty lists.

Will kupdate continue to enforce the "no dirty buffer older than 
XX" guarantee?

--
Daniel
