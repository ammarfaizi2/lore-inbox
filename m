Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWDXEkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWDXEkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 00:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWDXEkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 00:40:41 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:61139 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S1751509AbWDXEkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 00:40:40 -0400
Message-ID: <444C5698.5080503@openvz.org>
Date: Mon, 24 Apr 2006 08:39:52 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
CC: sekharan@us.ibm.com, akpm@osdl.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Valerie.Clement@bull.net
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>	<1145630992.3373.6.camel@localhost.localdomain>	<1145638722.14804.0.camel@linuxchandra>	<20060421155727.4212c41c.akpm@osdl.org>	<1145670536.15389.132.camel@linuxchandra>	<20060421191340.0b218c81.akpm@osdl.org>	<1145683725.21231.15.camel@linuxchandra> <20060424011053.B89707402F@sv1.valinux.co.jp>
In-Reply-To: <20060424011053.B89707402F@sv1.valinux.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> pzone based memory controller:
>>>> http://marc.theaimsgroup.com/?l=ckrm-tech&m=113867467006531&w=2
>>> From a super-quick scan that looks saner.  Is it effective?  Is this the
>>> way you're planning on proceeding?
>> Yes, it is effective, and the reclamation is O(1) too. It has couple of
>> problems by design, (1) doesn't handle shared pages and (2) doesn't
>> provide support for both min_shares and max_shares.
> 
> Right.  I wanted to show proof-of-cencept of the pzone based controller
> and implemented minimal features necessary as the memory controller.
> So, the pzone based controller still needs development and some cleanup.
Just out of curiosity, how it was meassured that it is effective?
How does it work when there is a global memory shortage in the system?

Thanks,
Kirill
