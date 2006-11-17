Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755578AbWKQJXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578AbWKQJXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 04:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755576AbWKQJXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 04:23:50 -0500
Received: from cantor2.suse.de ([195.135.220.15]:61862 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755562AbWKQJXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 04:23:49 -0500
From: Andi Kleen <ak@suse.de>
To: Hasso Tepper <hasso@estpak.ee>
Subject: Re: Sysctl syscall
Date: Fri, 17 Nov 2006 10:23:45 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200611160003.02681.hasso@estpak.ee> <p734psyczmb.fsf@bingen.suse.de> <200611171007.57596.hasso@estpak.ee>
In-Reply-To: <200611171007.57596.hasso@estpak.ee>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171023.45595.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 November 2006 09:07, Hasso Tepper wrote:

> I have process which drops root privileges after startup and retains only 
> some privileges using CAP_NET_ADMIN and CAP_SYS_ADMIN capabilities.
> I can change values in /proc/sys/net/ipv[46]/* (like turning forwarding 
> on/off) from this process using sysctl syscall, but I can't write 
> directly into /proc/sys/net/ipv[46]/* from it.

That sounds more like a security bug than a feature to be preserved.

-Andi 
