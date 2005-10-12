Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbVJLP53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbVJLP53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVJLP53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:57:29 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:53905 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751472AbVJLP52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:57:28 -0400
Message-ID: <434D3266.9000203@gentoo.org>
Date: Wed, 12 Oct 2005 16:57:26 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com> <434D2DF1.9070709@gentoo.org>
In-Reply-To: <434D2DF1.9070709@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Do you have any suggestions for how I can compute the value of via_clock 
> in userspace? (i.e. some equivalent of system_bus_clock())

Uh, looks like the kernel just assumes 33mhz unless overriden by the user. Is 
this assumption generally accurate?
If it is not, then there's probably no point displaying timing info...

Daniel
