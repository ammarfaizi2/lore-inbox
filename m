Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTEZEY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTEZEY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:24:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4243 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263861AbTEZEY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:24:27 -0400
Date: Mon, 26 May 2003 05:37:37 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: netlink init order
Message-ID: <20030526043737.GN6270@parcelfarce.linux.theplanet.co.uk>
References: <20030525.190710.112599236.davem@redhat.com> <Pine.LNX.4.44.0305251922310.1621-100000@home.transmeta.com> <20030526025016.GM6270@parcelfarce.linux.theplanet.co.uk> <20030525.195541.55750468.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525.195541.55750468.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 07:55:41PM -0700, David S. Miller wrote:
>    From: viro@parcelfarce.linux.theplanet.co.uk
>    Date: Mon, 26 May 2003 03:50:16 +0100
> 
>    Err...  That should be
>    
>    +module_init(init_netlink)
>    +module_exit(cleanup_netlink)
>    
> That's exactly what I said.

Yeah - I saw your mail right after I'd sent reply.
 
> Al, are you able to read any of my emails?  I sent you one last week
> with a patch for fs/proc/task_mmu.c warnings on 64-bit and it
> aparently went to the bit bucket...

Looks like that one had ;-/  Resend it, OK?
