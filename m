Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269132AbUIXUnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269132AbUIXUnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269121AbUIXUmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:42:33 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:8688 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269136AbUIXUlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:41:50 -0400
Message-ID: <4154867F.7030108@nortelnetworks.com>
Date: Fri, 24 Sep 2004 14:41:35 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net>
In-Reply-To: <20040924132247.W1973@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

> 2. Problem is the execve(2) that the mlock(1) program would have to call.
> This blows away the mappings which contain the locking info.

Does it?  The man page said it isn't inherited on fork(), but why wouldn't it be 
inherited on exec()?

Chris
