Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVA0Xxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVA0Xxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVA0Xwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:52:32 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:57070 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261312AbVA0Xti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:49:38 -0500
Message-ID: <41F97E07.2040709@comcast.net>
Date: Thu, 27 Jan 2005 18:49:27 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org,
       "Trever L. Adams" <tadams-lists@myrealbox.com>
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a  
 threading error
References: <217740000.1106412985@[10.10.2.4]>	<41F30E0A.9000100@osdl.org>	<1106482954.1256.2.camel@tux.rsn.bth.se> <20050126132504.3295e07d@dxpl.pdx.osdl.net>
In-Reply-To: <20050126132504.3295e07d@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From strace output which Trever sent, OO.o seems to be getting many 
-EINTRs (Interrupted System Call) which are attempted to be restarted 
but again recieve EINTR when restarted. (futex, accept and poll are the 
ones which get EINTR).

Whereas, when OO.o successfully starts up on my machine, I get no EINTRs 
at all.

Stephen - Is it possible for you to post strace from your machine ? If 
you see the same symptoms we can look at what changed in that area.

Thanks
Parag

Stephen Hemminger wrote:

>On my laptop with Fedora Core 3, OpenOffice 1.0.1, 1.0.4 and the pre 2.0 version
>all work fine running 2.6.10-FCxx kernel but get a SEGV when running on 2.6.11-rc1 or 2.6.11-rc2
>
>Any hints?
>
>
>  
>

