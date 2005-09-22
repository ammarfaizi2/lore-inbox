Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbVIVKOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbVIVKOE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 06:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVIVKOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 06:14:04 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:50317 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S1751452AbVIVKOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 06:14:02 -0400
Message-ID: <433283E2.20706@ens-lyon.org>
Date: Thu, 22 Sep 2005 12:13:54 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel panic during SysRq-b on Alpha
References: <43315BEB.3010909@ens-lyon.org> <20050922101259.A29179@jurassic.park.msu.ru> <20050921234232.1034cc02.akpm@osdl.org> <20050922130449.A29503@jurassic.park.msu.ru>
In-Reply-To: <20050922130449.A29503@jurassic.park.msu.ru>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22.09.2005 11:04, Ivan Kokshaysky a écrit :
> On Wed, Sep 21, 2005 at 11:42:32PM -0700, Andrew Morton wrote:
> 
>>Wow, never seen that done before.  Does it actually work?  For keyboard,
>>serial console and /proc/sysrq-trigger?
> 
> 
> Yes, all of this works for me.

Thanks a lot, works here too (only tried on serial console).

By the way, Ivan, do you have problems with gcc 4 on alpha ?
All kernels I tried between 2.6.11 and 2.6.13 with Debian gcc-4.0.1-2
have a strange bug that does not appear with gcc 3.3 and 3.4
(non-root ssh sessions are immediately closed).

Regards,
Brice
