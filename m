Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTDOVYv (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTDOVYv 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:24:51 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19613 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264088AbTDOVYt 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 17:24:49 -0400
Date: Tue, 15 Apr 2003 14:35:22 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Nigel Cunningham <ncunningham@clear.net.nz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: New Software Suspend Patch for testing.
In-Reply-To: <1050442411.2983.5.camel@laptop-linux.cunninghams>
Message-ID: <Pine.LNX.4.44.0304151432410.912-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One more problem is that you're also trying to follow a moving target
> :>. In response to Pavel's last request, I'm preparing to work toward
> using a linked list for the meta information (to allow unlimited image
> size), and at the request of others, compressing (zlib) the saved pages
> to make the image faster to save/load.

The issue is not following a moving target. It's reading poorly maintained 
and documented code. 

If I were you, I would work first at cleaning up the code, then work on 
adding features to it. There were many opportunities I found for 
improvement when reworking the code, plus it became orders of magnitude 
easier to follow. 


	-pat

