Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264333AbUD0UdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbUD0UdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbUD0UdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:33:12 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:15366 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264333AbUD0UdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:33:10 -0400
Message-ID: <408EC478.9090502@techsource.com>
Date: Tue, 27 Apr 2004 16:37:12 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Grzegorz Kulewski <kangur@polcom.net>, Marc Boucher <marc@linuxant.com>,
       Adam Jaskiewicz <ajjaskie@mtu.edu>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, torvalds@osdl.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu> <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com> <408E9C59.2090502@nortelnetworks.com> <Pine.LNX.4.58.0404271950170.4424@alpha.polcom.net> <408EA22C.4090408@nortelnetworks.com>
In-Reply-To: <408EA22C.4090408@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Friesen wrote:
> Grzegorz Kulewski wrote:
> 
>> Maybe kernel should display warning only once per given licence or 
>> even once per boot (who needs warning about tainting tainted kernel?)
> 
> 
> I think that's a very good point.  If the kernel is already tainted, 
> maybe we don't need to print out additional taint messages.
> 


That could be confusing if it's important for the user to know which 
modules taint the kernel.  If tainting is only mentioned for the first 
tainting, then the user might be lead to believe that subsquent ones do 
not taint the kernel, even though they do.

