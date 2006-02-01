Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWBAQP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWBAQP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWBAQP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:15:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11728 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964942AbWBAQPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:15:55 -0500
Date: Wed, 1 Feb 2006 11:15:41 -0500
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: more cfq spinlock badness
Message-ID: <20060201161541.GD5875@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060131063938.GA1876@redhat.com> <20060131090944.GU4215@suse.de> <20060131173601.GA7204@redhat.com> <20060201110228.GS4215@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201110228.GS4215@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 12:02:28PM +0100, Jens Axboe wrote:

 > >  > if you are using that? The bug above has in the
 > >  > past always been able to be explained by a driver destroying a structure
 > >  > embedding the queue lock before the queue is dead.
 > > 
 > > as there were no ub devices plugged in at the time, I think
 > > Pete is off the hook for this one.
 > 
 > The ub fix hasn't been merged yet.

Really? I thought Pete synced up a whole bunch of ub bits including that already.

 > Just trying to be absolutely certain
 > that you didn't have that loaded?

99.9% sure. (It was a few days ago, and I'm already forgetting details).

		Dave

