Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVGTOcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVGTOcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVGTOcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:32:20 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:60967 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261243AbVGTOcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:32:16 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,303,1114984800"; 
   d="scan'208"; a="12866408:sNHT26947556"
Message-ID: <42DE606D.9090900@fujitsu-siemens.com>
Date: Wed, 20 Jul 2005 16:32:13 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: files_lock deadlock?
References: <42DD2E37.3080204@fujitsu-siemens.com> <Pine.LNX.4.61.0507191948120.89@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0507191948120.89@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

> I'm probably stabbing in the dark, but I've seen ipt_owner of netfilter to 
> talk about spin_lock_bh() wrt. files->file_lock.

That is a different lock. I am talking about the global files_lock 
(include/linux/fs.h)

Regards
Martin


-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
