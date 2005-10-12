Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVJLPi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVJLPi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVJLPi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:38:28 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:31427 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964804AbVJLPi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:38:27 -0400
Message-ID: <434D2DF1.9070709@gentoo.org>
Date: Wed, 12 Oct 2005 16:38:25 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com>
In-Reply-To: <58cb370e050927062049be32f8@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> I would prefer /proc/via
> to vanish because it complicates driver needlessly (could you do
> this in separate patch?).

I'm working on a user-space app to provide the same info. It's nearly there 
but lacking some timing info.

Do you have any suggestions for how I can compute the value of via_clock in 
userspace? (i.e. some equivalent of system_bus_clock())

Thanks,
Daniel
