Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263660AbREYI5K>; Fri, 25 May 2001 04:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263661AbREYI5B>; Fri, 25 May 2001 04:57:01 -0400
Received: from t2.redhat.com ([199.183.24.243]:60151 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263660AbREYI4y>; Fri, 25 May 2001 04:56:54 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010525005458.A16774@bug.ucw.cz> 
In-Reply-To: <20010525005458.A16774@bug.ucw.cz> 
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: jffs on non-mtd device (small bug) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2001 09:56:45 +0100
Message-ID: <24956.990781005@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pavel@suse.cz said:
>  BTW the printk probably should be KERN_ERR, because this "warning" is
> fatal. 

Surely it's only fatal if it's the root filesystem, and the panic() message
on being unable to mount the root filesystem already has a higher loglevel?

--
dwmw2


