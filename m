Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUBRInX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 03:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUBRInX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 03:43:23 -0500
Received: from test.estpak.ee ([194.126.115.47]:5629 "EHLO arena.estpak.ee")
	by vger.kernel.org with ESMTP id S263800AbUBRInW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 03:43:22 -0500
From: Hasso Tepper <hasso@estpak.ee>
To: davids@webmaster.com
Subject: Re: raw sockets and blocking
Date: Wed, 18 Feb 2004 10:43:12 +0200
User-Agent: KMail/1.6.1
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKIEMGKHAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEMGKHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Disposition: inline
Organization: Elion Enterprises Ltd.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402181043.12913.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> > I'm guessing the driver or network layer is
> > blocking the socket because it is waiting for the link to come
> > back, however would it not be better to discard the packet,
> > especially a raw packet?
>
> 	If you want to discard the packet, you do it. Why should the
> kernel accept a packet just to discard it if it's smart enough to
> not accept it?

>From "man sendmsg" in Debian unstable (manpage is dated 2003-10-25).

ENOBUFS
The output queue for a network interface was full.  This generally 
indicates that the interface  has  stopped  sending, but  may be 
caused by transient congestion.  (Normally, this does not occur in 
Linux. Packets are just silently dropped when a device queue 
overflows.)

-- 
Hasso Tepper
Elion Enterprises Ltd.
WAN administrator
