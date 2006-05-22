Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWEVVGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWEVVGs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWEVVGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:06:48 -0400
Received: from palrel11.hp.com ([156.153.255.246]:60046 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1750959AbWEVVGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:06:47 -0400
Message-ID: <447227D4.4050407@hp.com>
Date: Mon, 22 May 2006 14:06:28 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vlad Yasevich <vladislav.yasevich@hp.com>,
       Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Was change to ip_push_pending_frames intended to break	udp	(more
 specifically, WCCP?)
References: <20060520191153.GV3776@stingr.net>	<20060520140434.2139c31b.akpm@osdl.org>	<1148322152.15322.299.camel@galen.zko.hp.com> <4472078D.8010706@hp.com> <1148332293.17376.114.camel@localhost.localdomain>
In-Reply-To: <1148332293.17376.114.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-05-22 at 11:48 -0700, Rick Jones wrote:
> 
>>ID of zero again?  I thought that went away years ago?  Anyway, given 
>>the number of "helpful" devices out there willing to clear the DF bit, 
>>fragment and forward, perhaps always setting the IP ID to 0, even if DF 
>>is set, isn't such a good idea?
> 
> 
> Any device that clears DF is so terminally broken that you've already
> lost the battle the moment you bought it. 

Perhaps, but still, always setting the IP datagram ID to the same value 
even with the DF bit set seems contrary to the "conservative in what we 
send" that is so often brought-forth as a reason a stack behaves the way 
it does.

rick jones
