Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbUCCPeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbUCCPep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:34:45 -0500
Received: from ida.rowland.org ([192.131.102.52]:2308 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262490AbUCCPei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:34:38 -0500
Date: Wed, 3 Mar 2004 10:34:37 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: "Yury V. Umanets" <umka@namesys.com>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Does the block layer prevent races between open() and unregister()?
In-Reply-To: <1078301208.3493.8.camel@firefly>
Message-ID: <Pine.LNX.4.44L0.0403031030500.890-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Yury V. Umanets wrote:

> On Sat, 2004-02-28 at 06:05, Alan Stern wrote:
> > A classic race that all drivers for hot-unpluggable devices have to deal 
> > with is the race between open() and unregister() (or disconnect()).
> > 
> > Does the block layer have any mechanism to prevent such races?  Or does it 
> > rely on the lower-level drivers handling such things by themselves?
> According to usb-skel driver, nobody cares about.

The usb-skeleton isn't relevant to this question because it doesn't use 
the block layer.

Alan Stern

