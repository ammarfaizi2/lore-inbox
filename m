Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTEOCmM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263755AbTEOCmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:42:12 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:25985
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263752AbTEOCmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:42:11 -0400
Date: Wed, 14 May 2003 22:45:38 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Patrick Mochel <mochel@osdl.org>
cc: Andrew Morton <akpm@digeo.com>, "" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
In-Reply-To: <Pine.LNX.4.44.0305141935440.9816-100000@cherise>
Message-ID: <Pine.LNX.4.50.0305142243440.19782-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0305141935440.9816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Patrick Mochel wrote:

> Interesting. This is yet more proof that system-level devices cannot be
> treated as common, everyday devices. Sure, it's nice to see them show up
> in sysfs with little overhead, and very nice not to have to work about
> them during shutdown or power transitions. But there are just too many
> special cases (like getting the ordering right ;) that you have to worry
> about.
> 
> So, what do we do with them? 

Does the PIC shutdown callback get called _just_ before acpi_power_off?

	Zwane
-- 
function.linuxpower.ca
