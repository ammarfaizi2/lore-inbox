Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVDYWYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVDYWYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVDYWYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:24:54 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:1739 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261266AbVDYWYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:24:46 -0400
Message-ID: <426D6DFA.4090908@ammasso.com>
Date: Mon, 25 Apr 2005 17:23:54 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Roland Dreier <roland@topspin.com>, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	<20050411142213.GC26127@kalmia.hozed.org>	<52mzs51g5g.fsf@topspin.com>	<20050411163342.GE26127@kalmia.hozed.org>	<5264yt1cbu.fsf@topspin.com>	<20050411180107.GF26127@kalmia.hozed.org>	<52oeclyyw3.fsf@topspin.com>	<20050411171347.7e05859f.akpm@osdl.org>	<4263DEC5.5080909@ammasso.com>	<20050418164316.GA27697@infradead.org>	<4263E445.8000605@ammasso.com>	<20050423194421.4f0d6612.akpm@osdl.org>	<426BABF4.3050205@ammasso.com>	<52is2bvvz5.fsf@topspin.com>	<20050425135401.65376ce0.akpm@osdl.org>	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
In-Reply-To: <20050425151459.1f5fb378.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> The way we expect get_user_pages() to be used is that the kernel will use
> get_user_pages() once per application I/O request.

Are you saying that the mapping obtained by get_user_pages() is valid only within the 
context of the IOCtl call?  That once the driver returns from the IOCtl, the mapping 
should no longer be used?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
