Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVDZCRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVDZCRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 22:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVDZCRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 22:17:40 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:40847 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261280AbVDZCRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 22:17:35 -0400
Message-ID: <426DA495.4040700@ammasso.com>
Date: Mon, 25 Apr 2005 21:16:53 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
CC: Roland Dreier <roland@topspin.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	<20050411142213.GC26127@kalmia.hozed.org>	<52mzs51g5g.fsf@topspin.com>	<20050411163342.GE26127@kalmia.hozed.org>	<5264yt1cbu.fsf@topspin.com>	<20050411180107.GF26127@kalmia.hozed.org>	<52oeclyyw3.fsf@topspin.com>	<20050411171347.7e05859f.akpm@osdl.org>	<4263DEC5.5080909@ammasso.com>	<20050418164316.GA27697@infradead.org>	<4263E445.8000605@ammasso.com>	<20050423194421.4f0d6612.akpm@osdl.org>	<426BABF4.3050205@ammasso.com>	<52is2bvvz5.fsf@topspin.com>	<20050425135401.65376ce0.akpm@osdl.org>	<521x8yv9vb.fsf@topspin.com>	<20050425151459.1f5fb378.akpm@osdl.org>	<426D6D68.6040504@ammasso.com>	<20050425153256.3850ee0a.akpm@osdl.org>	<52vf6atnn8.fsf@topspin.com> <20050426020338.5909570488@sv1.valinux.co.jp>
In-Reply-To: <20050426020338.5909570488@sv1.valinux.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IWAMOTO Toshihiro wrote:

> If such memory were allocated by a driver, the memory could be placed
> in non-hotremovable areas to avoid the above problems.

How can the driver allocated 3GB of pinned memory on a system with 3.5GB of RAM?  Can 
vmalloc() or get_free_pages() allocate that much memory?
