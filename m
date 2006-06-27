Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161170AbWF0RU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbWF0RU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWF0RU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:20:27 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:39653 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932478AbWF0RU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:20:26 -0400
Message-ID: <44A1689B.7060809@candelatech.com>
Date: Tue, 27 Jun 2006 10:19:23 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Herbert Poetzl <herbert@13thfloor.at>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210625.144158000@localhost.localdomain>	<20060626134711.A28729@castle.nmd.msu.ru>	<449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru>	<44A00215.2040608@fr.ibm.com>	<20060627131136.B13959@castle.nmd.msu.ru>	<44A0FBAC.7020107@fr.ibm.com>	<20060627133849.E13959@castle.nmd.msu.ru>	<44A1149E.6060802@fr.ibm.com>	<m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>	<20060627160241.GB28984@MAIL.13thfloor.at> <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Herbert Poetzl <herbert@13thfloor.at> writes:
> 
> 
>>On Tue, Jun 27, 2006 at 05:52:52AM -0600, Eric W. Biederman wrote:
>>
>>>Inside the containers I want all network devices named eth0!
>>
>>huh? even if there are two of them? also tun?
>>
>>I think you meant, you want to be able to have eth0 in
>>_more_ than one guest where eth0 in a guest can also
>>be/use/relate to eth1 on the host, right?
> 
> 
> Right I want to have an eth0 in each guest where eth0 is
> it's own network device and need have no relationship to
> eth0 on the host.

How does that help anything?  Do you envision programs
that make special decisions on whether the interface is
called eth0 v/s eth151?

Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

