Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUDIAIi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 20:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUDIAIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 20:08:38 -0400
Received: from main.gmane.org ([80.91.224.249]:20609 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262256AbUDIAIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 20:08:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: cat /dev/hdb > /dev/null DoS
Date: Fri, 09 Apr 2004 02:10:55 +0200
Message-ID: <c54pi2$u9b$1@sea.gmane.org>
References: <20040408085518.B4607@beton.cybernet.src> <c539ur$h5e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508a5820.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: de, en
In-Reply-To: <c539ur$h5e$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i guess you have DMA enabled on /dev/hdb. I would expect, that the 
> system is at least 50% idle

i did
   dd if=/dev/hda of=/dev/null bs=1M
and noticed, that top shows 0% idle, but 95% wa - what ever that means.

Since i've got DMA turned on, i would expect the CPU to be 95% idle, 
instead 95% wa? what does "wa" stand for?

