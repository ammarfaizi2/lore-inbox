Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUFAHXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUFAHXm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 03:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUFAHXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 03:23:42 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:11904 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S264914AbUFAHXl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 03:23:41 -0400
Message-ID: <40BC2EFA.6090503@nodivisions.com>
Date: Tue, 01 Jun 2004 03:23:38 -0400
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: swappiness ignored
References: <40B43B5F.8070208@nodivisions.com> <40B45CB7.6010407@aitel.hist.no> <200405260940.i4Q9eJdS000767@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200405260940.i4Q9eJdS000767@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the "why swap at all" thread, there was mention of the 
/proc/sys/vm/swappiness tunable, and some people suggested echoing a zero to 
there if you want to minimize/disable swap usage, or echoing a 100 to 
maximize swap usage, etc.

But on my 2.6.5 system, I can echo a zero to there, then cat it back to make 
sure... then 30 seconds later cat it again, and it's been changed to 
something else (50, 60, 80something).

Is this supposed to be a value that can be manually adjusted, as some have 
claimed, or is it something the kernel manages automatically?  I definitely 
can't manually set it without having it overwritten shortly thereafter.

-Anthony
http://nodivisions.com/
