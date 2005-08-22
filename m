Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbVHVWSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbVHVWSs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVHVWSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:18:47 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:63367 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751354AbVHVWSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:18:45 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,130,1122847200"; 
   d="scan'208"; a="14413008:sNHT27418716"
Message-ID: <43099FDF.6030504@fujitsu-siemens.com>
Date: Mon, 22 Aug 2005 11:50:23 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: yhlu <yhlu.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel>	 <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com>	 <20050812133248.GN8974@wotan.suse.de>	 <42FCA97E.5010907@fujitsu-siemens.com>	 <42FCB86C.5040509@fujitsu-siemens.com>	 <20050812145725.GD922@wotan.suse.de>	 <86802c44050812093774bf4816@mail.gmail.com>	 <20050812164244.GC22901@wotan.suse.de> <86802c4405081210442b1bb840@mail.gmail.com>
In-Reply-To: <86802c4405081210442b1bb840@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yhlu wrote:
> why matrin need to make apic id to be greater than 0x10 when system is
> only 2way?

It's a scalable system where multiple boards may be combined. Anyway, I 
see nothing in the specs that says you must start counting CPUs from zero.

Regards
Martin



-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
