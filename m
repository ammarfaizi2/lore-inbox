Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264450AbUE3XYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUE3XYz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 19:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbUE3XYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 19:24:55 -0400
Received: from mail1.kontent.de ([81.88.34.36]:18916 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264450AbUE3XYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 19:24:54 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swappiness=0 makes software suspend fail.
Date: Mon, 31 May 2004 01:23:22 +0200
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@zip.com.au>,
       Stuart Young <cef-lkml@optusnet.com.au>, linux-kernel@vger.kernel.org,
       Rob Landley <rob@landley.net>, seife@suse.de
References: <200405280000.56742.rob@landley.net> <40B94546.4040605@yahoo.com.au> <20040530194731.GA895@elf.ucw.cz>
In-Reply-To: <20040530194731.GA895@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405310123.22136.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 30. Mai 2004 21:47 schrieb Pavel Machek:
> > Until something like this goes through, please don't fuglify
> > vmscan.c any more than it is... do the saving and restoring
> > thing that Nigel suggested please.
> 

Isn't that a race condition with setting swapiness?

	Regards
		Oliver
