Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUGHPf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUGHPf1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUGHPf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:35:27 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:41222 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263972AbUGHPfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:35:22 -0400
Message-ID: <40ED6F1A.7080101@techsource.com>
Date: Thu, 08 Jul 2004 11:58:18 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: kronos@kronoz.cjb.net
CC: linux-kernel@vger.kernel.org, programming@johnwross.com
Subject: Re: Increasing IDE Channels
References: <20040707225635.GA26832@dreamland.darkstar.lan>
In-Reply-To: <20040707225635.GA26832@dreamland.darkstar.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kronos wrote:
> John W. Ross <programming@johnwross.com> ha scritto:

> 
> Because hwifs are statically allocated, see drivers/ide/ide.c:
> 
> ide_hwif_t ide_hwifs[MAX_HWIFS];        /* master data repository */
> 
> Also if names are ide0..ide9, the following would be ide: and ide; (see
> init_hwif_data in drivers/ide/ide.c).
> 


Why wouldn't they be ide10 and ide11?

