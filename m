Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWEVSss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWEVSss (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWEVSss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:48:48 -0400
Received: from palrel13.hp.com ([156.153.255.238]:16315 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1751128AbWEVSsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:48:47 -0400
Message-ID: <4472078D.8010706@hp.com>
Date: Mon, 22 May 2006 11:48:45 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vlad Yasevich <vladislav.yasevich@hp.com>
Cc: Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Was change to ip_push_pending_frames intended to break udp	(more
 specifically, WCCP?)
References: <20060520191153.GV3776@stingr.net>	<20060520140434.2139c31b.akpm@osdl.org> <1148322152.15322.299.camel@galen.zko.hp.com>
In-Reply-To: <1148322152.15322.299.camel@galen.zko.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IP id is set to 0 on unconnected sockets when the DF bit is set (path
> mtu discovery is enabled).  Try issuing a connect() in your application
> and see if the ids are increasing again.

ID of zero again?  I thought that went away years ago?  Anyway, given 
the number of "helpful" devices out there willing to clear the DF bit, 
fragment and forward, perhaps always setting the IP ID to 0, even if DF 
is set, isn't such a good idea?

rick jones
