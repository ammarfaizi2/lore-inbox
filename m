Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbTH2Nyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 09:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTH2Nyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 09:54:37 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:24210 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S261197AbTH2Nyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 09:54:36 -0400
Message-ID: <3F4F5B1B.1030909@genebrew.com>
Date: Fri, 29 Aug 2003 09:54:35 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird problem with nforce2
References: <3F4F54F2.4080506@ihme.org>
In-Reply-To: <3F4F54F2.4080506@ihme.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Hästbacka wrote:
> My chipset is NForce2, and needs NVIDIA NForce/NForce2 so the agp 
> can work with full power. Thank you.

This is not true; AGP works perfectly fine with the in-kernel drivers. 
You can set your video card to use the in-kernel AGP even if it is 
Nvidia, I think (use the NvAgp option in XF86Config).

If not, maybe the patch has not been updated for the latest kernels, and 
you will have to wait for someone to do so. In that case, this list is 
not the place to ask.

-Rahul
-- 
Rahul Karnik
rahul@genebrew.com
http://www.genebrew.com/

