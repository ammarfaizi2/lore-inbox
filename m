Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268355AbUIPQbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268355AbUIPQbR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268186AbUIPQbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:31:16 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:64643 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268440AbUIPQ1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:27:12 -0400
Message-ID: <4149BEDA.9020307@nortelnetworks.com>
Date: Thu, 16 Sep 2004 10:27:06 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] inotify 0.9
References: <1095263565.19906.19.camel@vertex> <cic9os$ibd$1@gatekeeper.tmr.com>
In-Reply-To: <cic9os$ibd$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> If I were doing this, and I admit I may not understand all of the 
> features, I would have a bitmap per filesystem of inodes being watched, 
> and anything which did an action which might require notify would check 
> the bit. If the bit were set the filesystem and inode info would be 
> passed to user space which could do anything it wanted.

How do you identify the filesystem?  Whose mount namespace do you use if you 
have multiple processes in different namespaces watching what is really the same 
file?

Chris
