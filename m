Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270216AbRHGOXh>; Tue, 7 Aug 2001 10:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270215AbRHGOX1>; Tue, 7 Aug 2001 10:23:27 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:29428 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S270216AbRHGOXP>; Tue, 7 Aug 2001 10:23:15 -0400
Date: Tue, 7 Aug 2001 15:23:18 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] using writepage to start io
Message-ID: <20010807152318.H4036@redhat.com>
In-Reply-To: <01080623182601.01864@starship> <5.1.0.14.2.20010807123805.027f19a0@pop.cus.cam.ac.uk> <01080715292606.02365@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01080715292606.02365@starship>; from phillips@bonn-fries.net on Tue, Aug 07, 2001 at 03:29:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 07, 2001 at 03:29:26PM +0200, Daniel Phillips wrote:

>   Ext3 has its own writeback daemon

Ext3 has a daemon to schedule commits to the journal, but it uses the
normal IO scheduler for unforced writebacks.

Cheers,
 Stephen
