Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTJAFKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 01:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTJAFKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 01:10:17 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:29921 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S261932AbTJAFKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 01:10:13 -0400
Date: Wed, 1 Oct 2003 01:10:08 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 scheduling(?) oddness
Message-ID: <20031001051008.GD1416@Master>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031001032238.GB1416@Master> <20030930215512.1df59be3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930215512.1df59be3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 09:55:12PM -0700, Andrew Morton wrote:
> "Murray J. Root" <murrayr@brain.org> wrote:
> >
> > The render finishes in the same 30 minutes, then oowriter starts.
> >  oowriter takes about 3 seconds to load if no rendering is going on.
> 
> OpenOffice uses sched_yield() in strange ways which causes it to
> get hopelessly starved on 2.6 kernels.  I think RH have a fixed version,
> but I don't know if that has propagated into the upstream yet.
> 
> So...  Don't worry about OpenOffice too much.  Is the problem reproducible
> with other applications?

Nope - even tried it with KDE apps.
Write it off to OpenOffice, not test6.

That doesn't explain the major time increase of the render, though.
200% for 2.5.65 vs 2.6.0-test6 or 150% for 2.6.0-test5 vs 2.6.0-test6 is a 
bit extreme.

-- 
Murray J. Root

