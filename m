Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTINXL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 19:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbTINXL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 19:11:28 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:11483 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262050AbTINXL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 19:11:28 -0400
Message-ID: <3F64F59E.9060904@namesys.com>
Date: Mon, 15 Sep 2003 03:11:26 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan Filius <iafilius@xs4all.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Another ReiserFS (rpm database) issue (2.6.0-test5)
References: <Pine.LNX.4.53.0309141826030.9944@sjoerd.sjoerdnet>
In-Reply-To: <Pine.LNX.4.53.0309141826030.9944@sjoerd.sjoerdnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is interesting that we didn't get reports of corruption until 
2.6.0-test* came out, there must be immensely more users.

Apologies for that bug, I need to review what was used for testing the 
large writes patch, it must have been a test that does not write more 
than 4 GB.....:-/

-- 
Hans


