Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUFLWJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUFLWJa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 18:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264939AbUFLWJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 18:09:30 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:33694 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264937AbUFLWIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 18:08:42 -0400
Message-ID: <40CB7F09.6030301@linuxmail.org>
Date: Sun, 13 Jun 2004 08:09:13 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pavel@ucw.cz
CC: Herbert Xu <herbert@gondor.apana.org.au>, Pavel Machek <pavel@suse.cz>,
       Patrick Mochel <mochel@digitalimplant.org>,
       kernel list <linux-kernel@vger.kernel.org>, akpm@zip.com.au
Subject: Re: Fix memory leak in swsusp
References: <20040612084708.23965272BA@smtp.etmail.cz>
In-Reply-To: <20040612084708.23965272BA@smtp.etmail.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@ucw.cz wrote:
> At this point it is okay to memcpy - it is copying pagedir, at that point we are outside any critical session. --p

Ah. So you're not doing the atomic copy in this routine? Humble apologies.

Nigel

-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (417) 100 574 (mobile)
