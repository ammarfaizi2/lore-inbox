Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWDDJw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWDDJw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWDDJw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:52:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:24264 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964883AbWDDJw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:52:56 -0400
Message-ID: <443241F4.7080801@garzik.org>
Date: Tue, 04 Apr 2006 05:52:52 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Mauro Tassinari <mtassinari@cmanet.it>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: libata/sata status on ich[?]
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAyTp2U2YnGEW3ub1INE9nAAEAAAAA@cmanet.it> <44323C24.4010402@garzik.org> <44323DE9.7030106@gmail.com>
In-Reply-To: <44323DE9.7030106@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.7 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.7 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> This should be fixed by the ata_piix map patch I've submitted and is 
> currently in #upstream. [ P0 P1 P2 P3 ] should be [ P0 P2 P1 P3 ].

If you are referring to this fix:

> commit 79ea24e72e59b5f0951483cc4f357afe9bf7ff89
> Author: Tejun Heo <htejun@gmail.com>
> Date:   Fri Mar 31 20:01:50 2006 +0900
> 
>     [PATCH] ata_piix: fix ich6/m_map_db

then its already in linux-2.6.git, and 2.6.17-rc1.

	Jeff


