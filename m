Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVKUTcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVKUTcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVKUTcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:32:35 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:43652 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932187AbVKUTce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:32:34 -0500
Message-ID: <438220C3.4040602@nortel.com>
Date: Mon, 21 Nov 2005 13:32:19 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: netlink nlmsg_pid supposed to be pid or tid?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2005 19:32:20.0953 (UTC) FILETIME=[4A732490:01C5EED2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When using netlink, should "nlmsg_pid" be set to pid (current->tgid) or 
tid (current->pid)?

Chris


