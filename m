Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbSJAFiE>; Tue, 1 Oct 2002 01:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261494AbSJAFiE>; Tue, 1 Oct 2002 01:38:04 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:41222 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261493AbSJAFiE>;
	Tue, 1 Oct 2002 01:38:04 -0400
Date: Mon, 30 Sep 2002 22:41:12 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Patrick Mochel <mochel@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc][patch] driverfs multi-node(board) patch [2/2]
Message-ID: <20021001054112.GB5177@kroah.com>
References: <3D98F3AD.2030607@us.ibm.com> <3D98F450.8080003@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D98F450.8080003@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 06:03:12PM -0700, Matthew Dobson wrote:
> Patrick,
> 	Ok..  here are the real changes.  I'd really like to get some 
> 	feedback on what you (or anyone else) thinks of these proposed changes.  
> This sets up a generic topology initialization routine which should 
> discover all online nodes (boards), CPUs, and Memory Blocks at boot time.  
> It also makes the CPUs and memblks it discovers children of the appropriate 
> nodes.

Can you show an example output of what the directory structure now looks
like with this patch?

Curious,

greg k-h
