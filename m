Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263243AbTDCAe1>; Wed, 2 Apr 2003 19:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263274AbTDCAe1>; Wed, 2 Apr 2003 19:34:27 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26130 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263243AbTDCAe0>; Wed, 2 Apr 2003 19:34:26 -0500
Date: Wed, 2 Apr 2003 19:45:50 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200304030045.h330jok10685@devserv.devel.redhat.com>
To: James Simmons <jsimmons@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why moving driver includes ?
In-Reply-To: <mailman.1049324411.25620.linux-kernel2news@redhat.com>
References: <mailman.1049324411.25620.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why did you move the driver includes to include/video ? What is 
>> the reasoning here ?
>> 
>> For example, drivers/video/radeon.h moved to include/video/radeon.h

> Yes. You never know. The other big reason was so userland could have a 
> standard set of hardware header files to program graphics hardware. Now 
> SDL and directfb etc can use the same header files.

Yeah, but what does it have to do with kernel? You should have
gotten Uli to add them to glibc.

-- Pete
