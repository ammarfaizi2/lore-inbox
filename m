Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUANPrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 10:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUANPrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 10:47:09 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:10401 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261774AbUANPrG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 10:47:06 -0500
Date: Wed, 14 Jan 2004 23:47:12 +0800 (WST)
From: raven@themaw.net
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Autofs question (try 2)
In-Reply-To: <200401132141.45772.robin.rosenberg.lists@dewire.com>
Message-ID: <Pine.LNX.4.58.0401142342440.1783@raven.themaw.net>
References: <200401132141.45772.robin.rosenberg.lists@dewire.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The place for this is on the autofs list.

http://linux.kernel.org/mailman/listinfo/autofs

Short answer to your question is I don't think so. At least at the moment. 
I would have to check it out.

What version of autofs are you using?

On Tue, 13 Jan 2004, Robin Rosenberg wrote:

> Hi,
> 
> The first message was cut short, sorry
> 
> I grabbed the auto.smb script for mounting samba/windows shares. One of the flaws is that I'd
> like to get around is that it must be configured as root and most importantly that I don't see who 
> is requesting the mount. I was thinking along the line of mounting shares in /cifs/$USER/servers/share
> or simply mounting the share for the first user using the mount point (essentially single user machines
> anyway).
> 
> the auto.smb script is running as root and I printed some info in root.c at the revalidate
> 
> Jan 12 18:49:06 h6n2fls33o811 kernel: autofs4_root_revalidate, uid=505 name=10.1.1.4
> Jan 12 18:49:06 h6n2fls33o811 automount[22233]: attempting to mount entry /cifs/10.1.1.4
> Jan 12 18:49:06 h6n2fls33o811 kernel: autofs4_root_revalidate, uid=0 name=10.1.1.4
> Jan 12 18:49:06 h6n2fls33o811 logger: uid=0(root) gid=0(root) grupper=0(root)
> Jan 12 18:49:07 h6n2fls33o811 kernel: autofs4_root_revalidate, uid=0 name=10.1.1.4
> Jan 12 18:49:08 h6n2fls33o811 last message repeated 10 times
> and lots more from mounting with uid=0
> 
> Is there any simple way of passing the first uid to the automounter?
> 
> -- robin
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

