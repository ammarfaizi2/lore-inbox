Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbSLFTWX>; Fri, 6 Dec 2002 14:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbSLFTWX>; Fri, 6 Dec 2002 14:22:23 -0500
Received: from air-2.osdl.org ([65.172.181.6]:62424 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265661AbSLFTWW>;
	Fri, 6 Dec 2002 14:22:22 -0500
Date: Fri, 6 Dec 2002 13:10:16 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] bus notifiers for the generic device model 
In-Reply-To: <200212051614.gB5GEUN02667@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0212061307590.1010-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just to follow up..

> I'm happy with keeping probe and remove in the bus specific driver template 
> and having the <bustype>_add_driver install generic device probe and remove 
> routines to handle these cases.  My point was that the docs implied I should 
> use the generic driver probe and remove routines, which I can't without some 
> type of functionality like this.
> 
> If you envisage us never eliminating the driver specific probe and remove 
> routines, I'm happy.  I'm less happy if there will come a day when I have to 
> revisit all the converted drivers to do the elimination.

I don't see us eliminating the bus-specific probe() and remove() methods. 
At least not for a very long time.

	-pat

