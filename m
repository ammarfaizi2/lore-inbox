Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUFZWyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUFZWyl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 18:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUFZWyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 18:54:41 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:38160 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266505AbUFZWyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 18:54:39 -0400
Date: Sun, 27 Jun 2004 00:54:35 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Oliver Neukum <oliver@neukum.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040626225435.GE5526@pclin040.win.tue.nl>
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406262235.15688.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406262235.15688.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : mailhost.tue.nl 1182; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 10:35:15PM +0200, Oliver Neukum wrote:

> > +	cmd->cdb[2] = block >> 24;
> > +	cmd->cdb[3] = block >> 16;
> > +	cmd->cdb[4] = block >> 8;
> > +	cmd->cdb[5] = block;
> 
> we have macros for that.
> 
> > +	cmd->cdb[7] = nblks >> 8;
> > +	cmd->cdb[8] = nblks;
> 
> dito

Yes, we have macros. Using those macros would not at all be an improvement here.

Andries
