Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265151AbUF1Tum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbUF1Tum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbUF1Tum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:50:42 -0400
Received: from ida.rowland.org ([192.131.102.52]:26116 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265152AbUF1Tuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:50:32 -0400
Date: Mon, 28 Jun 2004 15:50:29 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Pete Zaitcev <zaitcev@redhat.com>, Greg KH <greg@kroah.com>,
       <arjanv@redhat.com>, <jgarzik@redhat.com>, <tburke@redhat.com>,
       <linux-kernel@vger.kernel.org>, <mdharm-usb@one-eyed-alien.net>,
       <david-b@pacbell.net>
Subject: Re: drivers/block/ub.c
In-Reply-To: <200406281842.28178.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0406281549290.2214-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, Oliver Neukum wrote:

> Am Montag, 28. Juni 2004 17:40 schrieb Alan Stern:
> > Or maybe I've misunderstood completely, not just partially.  In any case,
> > are you sure you will want to do this?  The directive for not tracking 
> > serial numbers or trying in some other way to make devices appear to be 
> > persistent across reconnects came directly from Linus.
> 
> IIRC he banned reconnecting device nodes in use.
> Reusing the number is legal. In fact in a finite number space there's
> always a chance that the number will have to be reused.

Sure.  But then why go to the trouble of tracking serial numbers to 
identify particular physical devices with particular minor numbers?

Alan Stern

