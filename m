Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUCTARt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 19:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUCTARt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 19:17:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38369 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263174AbUCTARs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 19:17:48 -0500
Message-ID: <405B8D9F.10008@pobox.com>
Date: Fri, 19 Mar 2004 19:17:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de> <405B2127.8090705@pobox.com> <200403200059.22234.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403200059.22234.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> The fact that spec says "supported" not "enabled" in description of word86
> makes me wonder - can they be disabled? (FLUSH CACHE is mandatory for General
> feature set and FLUSH CACHE EXT is mandatory if 48-bit LBA is supported)

IOW, "mandantory" isn't really mandantory, if you scale over time... 
Always check the identify-device feature bits before using a feature set :)

	Jeff



