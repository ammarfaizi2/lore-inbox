Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265453AbTFMRnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265454AbTFMRnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:43:45 -0400
Received: from host151.spe.iit.edu ([198.37.27.151]:28045 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S265453AbTFMRnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:43:45 -0400
Date: Fri, 13 Jun 2003 12:57:30 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm9
Message-ID: <20030613175730.GD24578@lostlogicx.com>
References: <20030613013337.1a6789d9.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613013337.1a6789d9.akpm@digeo.com>
X-Operating-System: Linux found.lostlogicx.com 2.4.20-pfeifer-r1_pre7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to compile this drivre and got a ton of undefined references to
psmouse_command ... haven't looked at the code yet, but I'd guess it
only works when builtin, not as a module?  Need an export symbol
somewhere?

--Brandon Low
Gentoo Dork/Dev :)

On Fri, 06/13/03 at 01:33:37 -0700, Andrew Morton wrote:
> +synaptics.patch
> +synaptics-cleanup.patch
> 
>  Synaptics driver (one flavour thereof)
