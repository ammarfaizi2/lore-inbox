Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933059AbWFZVVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbWFZVVx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933058AbWFZVVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:21:53 -0400
Received: from r16s03p19.home.nbox.cz ([83.240.22.12]:53477 "EHLO
	scarab.smoula.net") by vger.kernel.org with ESMTP id S933059AbWFZVVw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:21:52 -0400
Subject: Re: NFS and partitioned md
From: Martin Filip <bugtraq@smoula.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1151355509.9797.7.camel@lade.trondhjem.org>
References: <1151355145.4460.16.camel@archon.smoula-in.net>
	 <1151355509.9797.7.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-2
Date: Mon, 26 Jun 2006 23:21:50 +0200
Message-Id: <1151356910.4460.20.camel@archon.smoula-in.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust pí¹e v Po 26. 06. 2006 v 16:58 -0400:
> On Mon, 2006-06-26 at 22:52 +0200, Martin Filip wrote:
> > Hello to LKML,
> > 
> > few days ago I've changed my sw RAID5 to use md_d devices, which are
> > "partitonable". (major 254, minor dependant on partiton no)
> > 
> > The problem is with kernel space NFS daemon. When I create loopback
> > device and export it - everything works OK, but when exported directory
> > is directly something goes really wrong and it's not possible to mount
> > it.
> 
> Could we at the very least see a copy of your /etc/exports
> and /etc/fstab please?
of course... thought It's irelevant when it works with other devices...

$ cat /etc/exports 
/mnt/data/public            *(ro,all_squash,async)

mounted via
mount -t nfs 192.168.0.2:/mnt/data/public /mnt/tmp/


> 
> Cheers,
>   Trond
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

