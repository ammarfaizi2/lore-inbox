Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270662AbTG0ES4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 00:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270663AbTG0ES4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 00:18:56 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:15054 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270662AbTG0ESz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 00:18:55 -0400
Message-ID: <3F235A05.1000900@genebrew.com>
Date: Sun, 27 Jul 2003 00:50:13 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew de Quincey <adq_dvb@lidskialf.net>
CC: lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
References: <200307262309.20074.adq_dvb@lidskialf.net>
In-Reply-To: <200307262309.20074.adq_dvb@lidskialf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey wrote:
> Small patch for the latest nvidia nforce 1.0-261 nvnet drivers with kernel 2.5.

<snip>

I sent a similar patch based on your older one to the Gentoo maintainers 
a couple of days ago. Did you notice how the module reference counting 
(MOD_INC/MOD_DEC) seems to have moved out of their wrapper into the 
binary module (possible GPL violation) or removed completely (oops 
waiting to happen)? I wonder why.

To be safe, I added the refcounting back where it was in previous 
versions. Anyway, thanks for making these patches.

-Rahul

