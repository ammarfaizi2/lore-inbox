Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286167AbRLJGRY>; Mon, 10 Dec 2001 01:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286169AbRLJGRP>; Mon, 10 Dec 2001 01:17:15 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:26806 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S286167AbRLJGRD>;
	Mon, 10 Dec 2001 01:17:03 -0500
Message-ID: <3C145359.3090401@candelatech.com>
Date: Sun, 09 Dec 2001 23:16:57 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: question on select:  How big can the empty buffer space be before select returns ready-to-write?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For instance, it appears that select will return that a socket is
writable when there is, say 8k of buffer space in it.  However, if
I'm sending 32k UDP packets, this still causes me to drop packets
due to a lack of resources...

Is there any IOCTL that can tell select how much space to require
before it thinks a socket is writable?

Many thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


