Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVAYTAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVAYTAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVAYS6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:58:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47578 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262063AbVAYS5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:57:10 -0500
Date: Tue, 25 Jan 2005 13:56:54 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Michal Ludvig <michal@logix.cz>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <1106674694.13913.14.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0501251346140.27699-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005, Fruhwirth Clemens wrote:

> The changes, I purposed, shouldn't be too hard to implement. I will
> build a skeleton for Michael, but I can't test the code, as I don't own
> a padlock system, further

I've got one now, and can use it for testing.

> I'm sorry to say but, my time is somehow
> constrained.. I really gotta start to write my diploma thesis, I'm
> delaying this for too long for crypto stuff now.
> 
> But before I put that into the my queue, I would like to see some kind
> of decision on an async crypto framework. acrypto cames with hardware
> support. So, are we heading for hardware support in cryptoapi, hardware
> support in acrypto, acrypto instead of cryptoapi, OCF instead of
> cryptoapi, or put everything into the kernel and export 3 interface? 

Exact details are unknown at this stage.  If we can get permission to use
OCF, then we need to work out what's best.

> And how - when there is more than one interface - are these projects
> going to reuse code?

I would imagine so.


- James
-- 
James Morris
<jmorris@redhat.com>


