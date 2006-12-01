Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759246AbWLAO6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759246AbWLAO6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759285AbWLAO6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:58:53 -0500
Received: from smtp.nokia.com ([131.228.20.173]:2508 "EHLO mgw-ext14.nokia.com")
	by vger.kernel.org with ESMTP id S1759246AbWLAO6w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:58:52 -0500
Subject: Re: [PATCH] UBI: take 2
From: Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, haver@vnet.ibm.com,
       Josh Boyer <jwboyer@linux.vnet.ibm.com>, arnez@vnet.ibm.com,
       llinux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061130170624.94fde80d.akpm@osdl.org>
References: <1164824246.576.65.camel@sauron>
	 <20061130170624.94fde80d.akpm@osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Fri, 01 Dec 2006 16:29:12 +0200
Message-Id: <1164983352.20337.18.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 01 Dec 2006 14:29:11.0943 (UTC) FILETIME=[11DCB970:01C71555]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::061201162917-2E1BCBB0-1020F41C/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Thu, 2006-11-30 at 17:06 -0800, Andrew Morton wrote:
> --- a/drivers/mtd/ubi/cdev.c~git-ubi-fix
> +++ a/drivers/mtd/ubi/cdev.c
> @@ -1185,7 +1185,7 @@ static ssize_t vol_cdev_direct_write(str
>  			 len, vol_id, lnum, off);
>  
>  		err = ubi_eba_write_leb(ubi, vol_id, lnum, tbuf, off, len,
> -					UBI_DATA_UNKNOWN, &written, 0, NULL);
> +					UBI_DATA_UNKNOWN, &written, NULL);

I have re-based the ubi-2.6.git tree, my apologies for this. I hope I
have not caused you many troubles by this.

I also I have applied your fix.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)

