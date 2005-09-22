Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVIVKsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVIVKsl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 06:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbVIVKsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 06:48:41 -0400
Received: from [195.209.228.254] ([195.209.228.254]:7591 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1030251AbVIVKsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 06:48:41 -0400
Message-ID: <43328C07.9070001@yandex.ru>
Date: Thu, 22 Sep 2005 14:48:39 +0400
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: J Engel <joern@wohnheim.fh-wedel.de>, Peter Menzebach <pm-mtd@mw-itcon.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: data  loss on jffs2 filesystem on dataflash
References: <432817FF.10307@yandex.ru> <4329251C.7050102@mw-itcon.de> <4329288B.8050909@yandex.ru> <43292AC6.40809@mw-itcon.de> <43292E16.70401@yandex.ru> <43292F91.9010302@mw-itcon.de> <432FE1EF.9000807@yandex.ru> <432FEF55.5090700@mw-itcon.de> <433006D8.4010502@yandex.ru> <20050920133244.GC4634@wohnheim.fh-wedel.de> <20050921190759.GC467@openzaurus.ucw.cz>
In-Reply-To: <20050921190759.GC467@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> ext2 and anything that does not do journalling?
> 
> I do not thing behaviour on powerfail is part of block device definition.
> 
Pavel, AFAIU,

Joern meant that if HDD starts a block write operation, it will 
accomplish it even if power-fail happens (probably there are some 
capacitors there). So, it is impossible, say, that HDD has written one 
half of a sector and has not written the other half.

And he wanted to say that DataFlash HW does not guarante this. But, 
perhaps, adding a special HW, this is implementable.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
