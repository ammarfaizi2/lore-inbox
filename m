Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTDXITa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbTDXITa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:19:30 -0400
Received: from dyn-ctb-203-221-73-229.webone.com.au ([203.221.73.229]:41476
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261801AbTDXIT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:19:29 -0400
Message-ID: <3EA7A0CC.50005@cyberone.com.au>
Date: Thu, 24 Apr 2003 18:31:08 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in as-iosched:1210
References: <Pine.LNX.4.50.0304222259300.2085-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0304222259300.2085-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>I'm not sure wether you want this, it was during error handling from the 
>HBA driver (source was disk error).
>
>scsi1: ERROR on channel 0, id 3, lun 0, CDB: Read (10) 00 00 7f de 60 00 00 80 00 
>Info fld=0x7fdeb2, Current sdd: sense key Medium Error
>Additional sense: Unrecovered read error
>end_request: I/O error, dev sdd, sector 8380032
>Badness in as_add_request at drivers/block/as-iosched.c:1210
>
Thanks I'll have a look.

