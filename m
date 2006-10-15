Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWJOIUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWJOIUC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 04:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWJOIUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 04:20:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:14546 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932322AbWJOIUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 04:20:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gVsmQWoEA+COVs86bGxYmPbvIrYdMLk7ES1x6n+cclUws176k3CrCuDXTwK+713bz/W6R5Bb/RjkhU1bHOfYHY+ejytPuSA729PYgewcqHtD1BW+rTEgDIjidaFTf+IxAkblcN/TXdV6PeqsglPDdv06A6LpqQsCbZSQXDfo6F8=
Message-ID: <4531EF3A.70101@gmail.com>
Date: Sun, 15 Oct 2006 10:19:47 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Richard Knutsson <ricknu-0@student.ltu.se>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] Char: stallion, use pr_debug macro
References: <347066701121713986@wsc.cz> <4531E294.7050205@student.ltu.se>
In-Reply-To: <4531E294.7050205@student.ltu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson wrote:
> Sorry for the late respond, just saw it...
> 
> Jiri Slaby wrote:
>> stallion, use pr_debug macro
>>   
> As it is a driver, is it not recommended to use the "dev_dbg()" found in 
> include/linux/device.h, instead of pr_debug?

Only iff you have access to struct device. And you don't have here, but 2 prints 
in stl_initpcibrd. This would be fixed in next patch serie...

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
