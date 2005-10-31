Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbVJaR5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbVJaR5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVJaR5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:57:34 -0500
Received: from zrtps0kp.nortelnetworks.com ([47.140.192.56]:60829 "EHLO
	zrtps0kp.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932523AbVJaR5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:57:33 -0500
Message-ID: <43665B08.6040005@nortel.com>
Date: Mon, 31 Oct 2005 11:57:28 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: any fairness in NTPL pthread mutexes?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2005 17:57:28.0179 (UTC) FILETIME=[8E9E0430:01C5DE44]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using NPTL.

If I have a pthread mutex currently owned by a task, and two other tasks 
try to lock it, when the mutex is unlocked, are there any rules about 
the order in which the waiting tasks get the mutex (ie priority, FIFO, 
etc.)?

Thanks,

Chris
