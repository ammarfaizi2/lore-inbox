Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUF0PpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUF0PpW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 11:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbUF0PpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 11:45:22 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:20238 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263574AbUF0PpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 11:45:19 -0400
Date: Sun, 27 Jun 2004 17:45:15 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Andries Brouwer <aebr@win.tue.nl>,
       Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
       mdharm-usb@one-eyed-alien.net, david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040627154515.GI5526@pclin040.win.tue.nl>
References: <200406271624.18984.oliver@neukum.org> <Pine.LNX.4.44L0.0406271108190.10134-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0406271108190.10134-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 11:19:38AM -0400, Alan Stern wrote:

> My favorite approach has always been:
> 
> 	put_be32(cmd->cdb + 2, block);

Yes, not bad.

I still prefer writing explicitly what happens.
But this is a fairly clean alternative.

Andries
