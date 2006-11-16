Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162121AbWKPA0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162121AbWKPA0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162117AbWKPA0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:26:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:19990 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162116AbWKPA0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:26:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rEA/V49Wtuk1UpOJZl4kqPAwlR63gKrNbSSDK1ArDmpcqBuymDID899V7Zcf3sBGwmXylvuRHM9YujOLbi+vcEmF3WlA5RcepYQztJMZZKGBqiIXzP1kI47AnuoGLNNooGq5appL0svu37bkNlqlfzr47FJ1WKvl2FjIbNYLHGg=
Message-ID: <455BB01B.2080309@gmail.com>
Date: Thu, 16 Nov 2006 09:26:03 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-raid@vger.kernel.org, neilb@cse.unsw.edu.au, mingo@redhat.com,
       dm-devel@redhat.com
Subject: Re: Problem booting linux 2.6.19-rc5, 2.6.19-rc5-git6,      2.6.19-rc5-mm2
 with md raid 1 over lvm root
References: <41884.81.64.156.37.1163631254.squirrel@rousalka.dyndns.org>
In-Reply-To: <41884.81.64.156.37.1163631254.squirrel@rousalka.dyndns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Mailhot wrote:
> The failing kernels (I tried -rc5, -rc5-git6, -rc5-mm2 only print :
> 
> %<----
> device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
> dm-devel@redhat.com
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> %<-----
> 
> (I didn't bother copying the rest of the failing kernel dmesg, as sata
> initialisation fills the first half of the screen, then dm is initialised,
> then you only get the logical consequences of failing to detect the /
> volume. The sata part seems fine – it prints the name of the hard drives
> we want to use)
> 
> I'm attaching the dmesg for the working distro kernel (yes I know not 100%
> distro kernel, but very close to one), distro config , and the config I
> used in my test. If anyone could help me to figure what's wrong I'd be
> grateful.

Say 'y' not 'm' to SCSI disk support.

-- 
tejun
