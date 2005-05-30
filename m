Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVE3PFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVE3PFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 11:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVE3PDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 11:03:31 -0400
Received: from www.rapidforum.com ([80.237.244.2]:15853 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261646AbVE3PCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 11:02:35 -0400
Message-ID: <429B2ACA.5040901@rapidforum.com>
Date: Mon, 30 May 2005 17:01:30 +0200
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: vm-issues in 2.6.12-rc5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Even in 2.6.12rc5 the vm-problem is still there. On a gigabit-webserver, when it reaches around 4000 
downloaders, it slows-down immediately. Its no fs-issue or disk-issue because the lock-ups also 
happen when I try to open a file on /proc. Normally it needs no time to open it but when it reaches 
4000 sockets, it needs from 5-30 seconds to just open a "file". Its a dual Xeon with 8 GB Ram. Any idea?

Chris
