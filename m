Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWECQKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWECQKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWECQKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:10:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29886 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030234AbWECQKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:10:11 -0400
Date: Wed, 03 May 2006 12:10:10 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Advanced XIP File System
In-reply-to: <1146672118.20773.32.camel@pmac.infradead.org>
X-X-Sender: nico@localhost.localdomain
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jared Hulbert <jaredeh@gmail.com>, Josh Boyer <jwboyer@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0605031209170.28543@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
 <625fc13d0605021756v7a8e0d7p1e9d8e4c810bc092@mail.gmail.com>
 <Pine.LNX.4.64.0605022316550.28543@localhost.localdomain>
 <625fc13d0605030341h2a105f49r2b1b610547e30022@mail.gmail.com>
 <1146658275.20773.8.camel@pmac.infradead.org>
 <6934efce0605030845o6d313681x6b89bef71c28b3a9@mail.gmail.com>
 <Pine.LNX.4.64.0605031151120.28543@localhost.localdomain>
 <1146672118.20773.32.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006, David Woodhouse wrote:

> On Wed, 2006-05-03 at 11:57 -0400, Nicolas Pitre wrote:
> > First, is it worth it?
> 
> Quite possibly not. Even if you don't actually have kernel XIP, you may
> well decide just not to schedule userspace while the flash isn't in READ
> mode.

And we already have code to do just that.


Nicolas
