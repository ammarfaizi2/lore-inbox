Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUFZW6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUFZW6F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 18:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267216AbUFZW6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 18:58:05 -0400
Received: from mail1.kontent.de ([81.88.34.36]:9444 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266880AbUFZW6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 18:58:02 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: drivers/block/ub.c
Date: Sun, 27 Jun 2004 00:59:04 +0200
User-Agent: KMail/1.6.2
Cc: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406262235.15688.oliver@neukum.org> <20040626225435.GE5526@pclin040.win.tue.nl>
In-Reply-To: <20040626225435.GE5526@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406270059.04436.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 27. Juni 2004 00:54 schrieb Andries Brouwer:
> On Sat, Jun 26, 2004 at 10:35:15PM +0200, Oliver Neukum wrote:
> 
> > > +	cmd->cdb[2] = block >> 24;
> > > +	cmd->cdb[3] = block >> 16;
> > > +	cmd->cdb[4] = block >> 8;
> > > +	cmd->cdb[5] = block;
> > 
> > we have macros for that.
> > 
> > > +	cmd->cdb[7] = nblks >> 8;
> > > +	cmd->cdb[8] = nblks;
> > 
> > dito
> 
> Yes, we have macros. Using those macros would not at all be an improvement here.

How do you arrive at that unusual conclusion?

	Regards
		Oliver
