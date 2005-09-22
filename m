Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbVIVRDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbVIVRDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 13:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbVIVRDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 13:03:51 -0400
Received: from [195.209.228.254] ([195.209.228.254]:27578 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1030448AbVIVRDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 13:03:50 -0400
Message-ID: <4332E3F5.3040905@yandex.ru>
Date: Thu, 22 Sep 2005 21:03:49 +0400
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Pavel Machek <pavel@ucw.cz>, J Engel <joern@wohnheim.fh-wedel.de>,
       Peter Menzebach <pm-mtd@mw-itcon.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: data loss on jffs2 filesystem on dataflash
References: <432817FF.10307@yandex.ru> <4329251C.7050102@mw-itcon.de> <4329288B.8050909@yandex.ru> <43292AC6.40809@mw-itcon.de> <43292E16.70401@yandex.ru> <43292F91.9010302@mw-itcon.de> <432FE1EF.9000807@yandex.ru> <432FEF55.5090700@mw-itcon.de> <433006D8.4010502@yandex.ru> <20050920133244.GC4634@wohnheim.fh-wedel.de> <20050921190759.GC467@openzaurus.ucw.cz>            <43328C07.9070001@yandex.ru> <200509221646.j8MGkYo3017314@turing-police.cc.vt.edu>
In-Reply-To: <200509221646.j8MGkYo3017314@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Thu, 22 Sep 2005 14:48:39 +0400, "Artem B. Bityutskiy" said:
> 
>>Joern meant that if HDD starts a block write operation, it will 
>>accomplish it even if power-fail happens (probably there are some 
>>capacitors there). So, it is impossible, say, that HDD has written one 
>>half of a sector and has not written the other half.
> 
> Hard drives contain capacitors to prevent writing of runt sectors on
> a powerfail?  Didn't we go around this a while ago and decide it's mostly
> urban legend, and that plenty of people have seen runt/bad sectors?

No idea. But theoretically it should be so, at least "good" drives 
should. May be a competent person will comment on this, that's quite 
interesting.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
