Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266747AbUGUVzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266747AbUGUVzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 17:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUGUVzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 17:55:53 -0400
Received: from mx2.magma.ca ([206.191.0.250]:9668 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S266751AbUGUVyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 17:54:14 -0400
Subject: Re: [PATCH] delete devfs
From: Jesse Stockall <stockall@magma.ca>
To: Greg KH <greg@kroah.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040721212745.GC18110@kroah.com>
References: <20040721141524.GA12564@kroah.com>
	 <200407211626.55670.oliver@neukum.org> <20040721145208.GA13522@kroah.com>
	 <1090444782.8033.4.camel@homer.blizzard.org>
	 <20040721212745.GC18110@kroah.com>
Content-Type: text/plain
Message-Id: <1090446817.8033.18.camel@homer.blizzard.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Jul 2004 17:53:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 17:27, Greg KH wrote:
> 
> It fixes an obviously broken chunk of code that is not maintained by
> _anyone_.  And it will clean up all device drivers a _lot_ to have this
> gone, which will benifit everyone in the long run.
> 

Agreed, but this 'broken' chunk of code is 'working' for a lot of people
(whether or not this is due to pure luck is not the point)

> As for "right now"?  Why not?  I'm just embracing the new development
> model of the kernel :)

That's the point that Oliver and I raised, the "leave it till 2.7" (not
breaking things for real world users) argument seems stronger than the
"rip it now" (because it makes things cleaner, easier to code, etc)
argument. 

Devfs should never have made it in the kernel in the first place, but
ripping devfs out in the middle of a stable series does not solve any
problems, it creates them.

Is keeping devfs around for 2.6 really that much or a burden? When was
the last time you saw any mails on lkml asking for devfs support?

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

