Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263323AbSJCPFP>; Thu, 3 Oct 2002 11:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263330AbSJCPFP>; Thu, 3 Oct 2002 11:05:15 -0400
Received: from [203.117.131.12] ([203.117.131.12]:51437 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S263323AbSJCPEx>; Thu, 3 Oct 2002 11:04:53 -0400
Message-ID: <3D9C5DD6.40103@metaparadigm.com>
Date: Thu, 03 Oct 2002 23:10:14 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Kevin Corry <corryk@us.ibm.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
References: <02100307363402.05904@boiler> <20021003155023.C17513@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>+#define DEV_PATH			"/dev"
>>+#define EVMS_DIR_NAME			"evms"
>>+#define EVMS_DEV_NAME			"block_device"
>>+#define EVMS_DEV_NODE_PATH		DEV_PATH "/" EVMS_DIR_NAME "/"
>>+#define EVMS_DEVICE_NAME		DEV_PATH "/" EVMS_DIR_NAME "/" EVMS_DEV_NAME
> 
> 
> The kernel doesn't know about device names at all.

It does for specifying root devices and for devfs.

