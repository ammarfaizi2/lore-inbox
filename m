Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424336AbWKQIIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424336AbWKQIIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 03:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424330AbWKQIIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 03:08:05 -0500
Received: from smtp-out.neti.ee ([194.126.126.43]:59610 "EHLO smtp-out.neti.ee")
	by vger.kernel.org with ESMTP id S1162426AbWKQIIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 03:08:02 -0500
From: Hasso Tepper <hasso@estpak.ee>
To: Andi Kleen <ak@suse.de>
Subject: Re: Sysctl syscall
Date: Fri, 17 Nov 2006 10:07:57 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200611160003.02681.hasso@estpak.ee> <p734psyczmb.fsf@bingen.suse.de>
In-Reply-To: <p734psyczmb.fsf@bingen.suse.de>
Organization: Elion Enterprises Ltd.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171007.57596.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Hasso Tepper <hasso@estpak.ee> writes:
> > 2.4 and 2.6 kernels and would work with capabilities
> > (sys/capability.h)? Accessing `/proc/sys' directly isn't such
> > alternative as it doesn't work with capabilities.
>
> What do you mean with "/proc/sys doesn't work with capabilities"?

I have process which drops root privileges after startup and retains only 
some privileges using CAP_NET_ADMIN and CAP_SYS_ADMIN capabilities.
I can change values in /proc/sys/net/ipv[46]/* (like turning forwarding 
on/off) from this process using sysctl syscall, but I can't write 
directly into /proc/sys/net/ipv[46]/* from it.


regards,
 
-- 
Hasso Tepper
Elion Enterprises Ltd. [AS3249]
Data Communication Network Administrator
