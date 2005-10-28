Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbVJ1UI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbVJ1UI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVJ1UI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:08:26 -0400
Received: from mail11.bluewin.ch ([195.186.18.61]:63164 "EHLO
	mail11.bluewin.ch") by vger.kernel.org with ESMTP id S1030284AbVJ1UIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:08:24 -0400
Date: Fri, 28 Oct 2005 16:07:52 -0400
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: update overview document
Message-ID: <20051028200752.GB25468@krypton>
References: <ip2uk2.6o93wd.e2lyonk8o6q05pejbwmnb41jo.beaver@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ip2uk2.6o93wd.e2lyonk8o6q05pejbwmnb41jo.beaver@cs.helsinki.fi>
User-Agent: Mutt/1.5.9i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 06:48:02PM +0300, Pekka Enberg wrote:
> 
> (Andrew, sorry for the duplicate. The first batch was not sent to the
>  list.)
> 
> This patch updates the Documentation/filesystems/vfs.txt document. I
> rearranged and rewrote parts of the introduction chapter and added
> better headings for each section. I also added a description for the
> inode rename() operation which was missing and added links to some
> useful external VFS documentation.
 
How about splitting the API stuff into include/linux/fs.h as kerneldoc?
That way, it gets updated as well when the interface changes, and keeps
Documetation/DocBook/kernel-api.tmpl looking shiny new..

	Arthur
