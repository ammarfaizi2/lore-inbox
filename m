Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbTC0SbH>; Thu, 27 Mar 2003 13:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261273AbTC0SbH>; Thu, 27 Mar 2003 13:31:07 -0500
Received: from zachery.phunnypharm.org ([65.207.35.141]:58250 "EHLO
	zachery.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261271AbTC0SbG>; Thu, 27 Mar 2003 13:31:06 -0500
Date: Tue, 25 Mar 2003 18:35:34 -0500
From: Ben Collins <bcollins@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] increase BUS_ID_SIZE to 20
Message-ID: <20030325233534.GW29859@phunnypharm.org>
References: <20030318030045.GA367@phunnypharm.org> <Pine.LNX.4.33.0303251529140.999-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303251529140.999-100000@localhost.localdomain>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 03:31:24PM -0600, Patrick Mochel wrote:
> 
> On Mon, 17 Mar 2003, Ben Collins wrote:
> 
> > I've tried to figure a way around this without adding back a lot of
> > overhead, but I can't.
> > 
> > The reasoning, is the ieee1394 node's onyl way of a real unique
> > identifier is the EUI (the 64bit GUID). It's represented as a 16 digit
> > hex. However, each node additionally ca have unit directories.
> 
> > Please consider applying this patch.
> 
> Alright, you win. I'll add it to my tree.

Much appreciated.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
