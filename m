Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbTIRKI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 06:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbTIRKI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 06:08:29 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:11755 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263039AbTIRKI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 06:08:27 -0400
To: Mark de Vries <m.devries@nl.tiscali.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 1GB, highmem or no?
References: <3F68B0EE.1@nl.tiscali.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Sep 2003 00:28:29 +0200
In-Reply-To: <3F68B0EE.1@nl.tiscali.com>
Message-ID: <m3k7876odu.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark de Vries <m.devries@nl.tiscali.com> writes:

> I recently added some memory and now have 1GB and the kernel tells me:
> "Warning only 896MB will be used.
> Use a HIGHMEM enabled kernel.
> 896MB LOWMEM available."
> 
> So I'm not using ~128MB of my memory...
> 
> My question is: is enableling HIGHMEM worth it?

You may consider using a different split as well. I'm using 2 GB : 2 GB
split with 1 GB of RAM with no need for highmem.

BTW: Is it really safe to use something like 2.5 GB : 1.5 GB user/kernel
scheme? I don't want PAE nor HIGHMEM.
-- 
Krzysztof Halasa, B*FH
