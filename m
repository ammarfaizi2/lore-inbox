Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265083AbUF1QmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUF1QmX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUF1Qlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:41:32 -0400
Received: from mail1.kontent.de ([81.88.34.36]:63391 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265077AbUF1QlV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:41:21 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: drivers/block/ub.c
Date: Mon, 28 Jun 2004 18:42:28 +0200
User-Agent: KMail/1.6.2
Cc: Pete Zaitcev <zaitcev@redhat.com>, Greg KH <greg@kroah.com>,
       <arjanv@redhat.com>, <jgarzik@redhat.com>, <tburke@redhat.com>,
       <linux-kernel@vger.kernel.org>, <mdharm-usb@one-eyed-alien.net>,
       <david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0406281133360.1598-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0406281133360.1598-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406281842.28178.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 28. Juni 2004 17:40 schrieb Alan Stern:
> Or maybe I've misunderstood completely, not just partially.  In any case,
> are you sure you will want to do this?  The directive for not tracking 
> serial numbers or trying in some other way to make devices appear to be 
> persistent across reconnects came directly from Linus.

IIRC he banned reconnecting device nodes in use.
Reusing the number is legal. In fact in a finite number space there's
always a chance that the number will have to be reused.

	Regards
		Oliver

