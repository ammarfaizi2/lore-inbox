Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319196AbSIDP6j>; Wed, 4 Sep 2002 11:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319209AbSIDP6j>; Wed, 4 Sep 2002 11:58:39 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:14232 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S319196AbSIDP6i>;
	Wed, 4 Sep 2002 11:58:38 -0400
Message-ID: <3D762EC9.1040105@colorfullife.com>
Date: Wed, 04 Sep 2002 18:03:21 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> On Sun, 1 Sep 2002, Amos Waterland wrote:
> 
>> That is the fundamental problem with a userspace shared memory
>> implementation: write permissions on a message queue should grant
>> mq_send(), but write permissions on shared memory grant a lot more than
>> just that.
> 
> is it really a problem? As long as the read and write queues are separated
> per sender, all that can happen is that a sender is allowed to read his
> own messages - that is not an exciting capability.
> 
Messages with the same prio are ordered - a separated per sender queue 
would break SuS.

--	
	Manfred

