Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270765AbTG0NEv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 09:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270766AbTG0NEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 09:04:51 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:32169 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270765AbTG0NEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 09:04:50 -0400
Message-ID: <3F23D551.5000809@genebrew.com>
Date: Sun, 27 Jul 2003 09:36:17 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew de Quincey <adq_dvb@lidskialf.net>
CC: Marcelo Penna Guerra <eu@marcelopenna.org>,
       lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
References: <200307262309.20074.adq_dvb@lidskialf.net> <200307271222.13649.adq_dvb@lidskialf.net> <3F23BC1D.7070804@genebrew.com> <200307271301.41660.adq_dvb@lidskialf.net>
In-Reply-To: <200307271301.41660.adq_dvb@lidskialf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey wrote:

> I've just dumped the mmapped IO space on mine. The MAC address shows up at 
> offset 0xa8, but the amd8111e driver is looking for it at 0x160 (there's just 
> loads of 0x00 there).

Also, as Marcelo -- no, not that one, the other one :) -- there is some 
funky reversing of the MAC address needed. See the reverse loop in 
nvnet.c where the MAC address is being read from the registers.

Thanks,
Rahul
-- 
Rahul Karnik
rahul@genebrew.com

