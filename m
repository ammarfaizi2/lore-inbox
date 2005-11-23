Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbVKWPfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVKWPfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVKWPfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:35:48 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:11406 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751007AbVKWPfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:35:47 -0500
Date: Wed, 23 Nov 2005 10:35:44 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Bob Copeland <me@bobcopeland.com>
cc: linux-kernel@vger.kernel.org, <usb-storage@lists.one-eyed-alien.net>,
       <mdharm-usb@one-eyed-alien.net>
Subject: Re: [usb-storage] [PATCH] usb-storage: Add support for Rio Karma
In-Reply-To: <20051123040752.GA5595@hash.localnet>
Message-ID: <Pine.LNX.4.44L0.0511231034480.4477-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Bob Copeland wrote:

> Add support for the Rio Karma portable digital audio player to usb-storage.

> +	if (!(recv = kmalloc(RECV_LEN, GFP_KERNEL | __GFP_DMA)))

You don't want to use __GFP_DMA here.

Alan Stern

