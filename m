Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTEMOzf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTEMOzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:55:35 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24808 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261351AbTEMOzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:55:33 -0400
Date: Tue, 13 May 2003 08:08:35 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Ben Collins <bcollins@debian.org>
cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
In-Reply-To: <20030513071412.GS433@phunnypharm.org>
Message-ID: <Pine.LNX.4.44.0305130808040.9816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 May 2003, Ben Collins wrote:

> On Tue, May 13, 2003 at 08:10:32AM +0100, Christoph Hellwig wrote:
> > On Tue, May 13, 2003 at 02:26:40AM -0400, Ben Collins wrote:
> > > This was causing me all sorts of problems with linux1394's 16-18 byte
> > > long bus_id lengths. The sysfs names were all broken.
> > > 
> > > This not only makes KOBJ_NAME_LEN match BUS_ID_SIZE, but fixes the
> > > strncpy's in drivers/base/ so that it can't happen again (atleast the
> > > strings will be null terminated).
> > 
> > What about defining BUS_ID_SIZE in terms of KOBJ_NAME_LEN?
> 
> Ok, then add this in addition to the previous patch.

I'll add this, and sync with Linus this week, if he doesn't pick it up.

Thanks,


	-pat

