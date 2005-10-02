Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVJBC0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVJBC0p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 22:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbVJBC0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 22:26:45 -0400
Received: from mail.ctyme.com ([69.50.231.10]:1220 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1750947AbVJBC0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 22:26:44 -0400
Message-ID: <433F4563.5060700@perkel.com>
Date: Sat, 01 Oct 2005 19:26:43 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Making nice niser for system hogging programs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a thought -----

Programs like cp -a /bigdir /backup and rsync usually bring the server 
to a crawl no matter how much "nice" you put on them. Is there any way 
to make "nice" smarter in that it limits io as well as processor usage? 
If cp and rsyne ran a little slower IO wise then everything else could 
run too.

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

