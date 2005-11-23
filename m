Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVKWSjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVKWSjs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVKWSjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:39:48 -0500
Received: from hera.cwi.nl ([192.16.191.8]:2266 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S932160AbVKWSjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:39:47 -0500
Date: Wed, 23 Nov 2005 19:39:26 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bob Copeland <me@bobcopeland.com>, usb-storage@lists.one-eyed-alien.net,
       linux-kernel@vger.kernel.org
Subject: Re: [usb-storage] Re: [PATCH] usb-storage: Add support for Rio Karma
Message-ID: <20051123183924.GA1016@apps.cwi.nl>
References: <20051123113342.GA5815@hash.localnet> <Pine.LNX.4.44L0.0511231316410.12957-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0511231316410.12957-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 01:18:30PM -0500, Alan Stern wrote:

> And do you really need US_FL_FIX_INQUIRY?  Hardly any devices do (maybe 
> none).

This one does:

/* aeb */
UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xffff,
                "Feiya",
                "5-in-1 Card Reader",
                US_SC_DEVICE, US_PR_DEVICE, NULL,
                US_FL_FIX_CAPACITY ),

Andries
