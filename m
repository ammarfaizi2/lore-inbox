Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUGSNdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUGSNdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 09:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUGSNdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 09:33:50 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:31943 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265250AbUGSNdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 09:33:49 -0400
Message-ID: <40FBCD8F.1080300@nortelnetworks.com>
Date: Mon, 19 Jul 2004 09:33:03 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Kent <raven@themaw.net>
CC: John McCutchan <ttb@tentacle.dhs.org>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nautilus-list@gnome.org
Subject: Re: [PATCH] inotify 0.5
References: <Pine.LNX.4.58.0407191642080.8909@wombat.indigo.net.au>
In-Reply-To: <Pine.LNX.4.58.0407191642080.8909@wombat.indigo.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent wrote:

> So the number of watches is restricted to the max number of file
> handles/process?

Note: I have not read the code.  We should probably do so before speculating.

However, it looks like you have one fd, and reading from it gives you a data 
structure of information about the event.  The max number of watches could be as 
high as INT_MAX depending on implementation.

Chris
