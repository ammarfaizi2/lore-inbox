Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270981AbTGPR3r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270994AbTGPR22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:28:28 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:39058 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S270989AbTGPRPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:15:10 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>, Fredrik Tolf <fredrik@dolda2000.cjb.net>
Subject: Re: Input layer demand loading
Date: Wed, 16 Jul 2003 19:28:35 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200307131839.49112.fredrik@dolda2000.cjb.net> <200307161457.42862.fredrik@dolda2000.cjb.net> <20030716162639.GB7513@kroah.com>
In-Reply-To: <20030716162639.GB7513@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307161928.35476.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> True, but then if you try to open the port, you will only get the base
> joydev.o module loaded, not the gameport driver, which is what you
> _really_ want to have loaded, right?
> 
> So there really isn't much benifit to doing this, sorry.

Why? It could work the way PCMCIA SCSI works.
Cardmgr loads the LLDD, but sd, sg, etc. are loaded
on demand.

	Regards
		Oliver

