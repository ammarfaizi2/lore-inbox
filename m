Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbTBQTB2>; Mon, 17 Feb 2003 14:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267287AbTBQTB2>; Mon, 17 Feb 2003 14:01:28 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:38055 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S267281AbTBQTB0>; Mon, 17 Feb 2003 14:01:26 -0500
Message-ID: <3E5133D6.5020806@nortelnetworks.com>
Date: Mon, 17 Feb 2003 14:11:18 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fcntl and flock wakeups not FIFO?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been doing some experimenting with locking on 2.4.18 and have 
noticed that if I have a number of writers waiting on a lock, they are 
not woken up in the order in which they requested the lock.

Is this expected?  If so, what was the reasoning for this and are there 
any patches to give FIFO wakeups?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com


