Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbTIPPYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTIPPYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:24:45 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:16914 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S261946AbTIPPYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:24:44 -0400
Message-ID: <3F672B55.3000600@techsource.com>
Date: Tue, 16 Sep 2003 11:25:09 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Dave Jones <davej@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       richard.brunner@amd.com, alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <Pine.LNX.3.96.1030916094748.26515B-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Davidsen wrote:

> 
> If the fixup were not in place, would it be useful to emit a warning
> like "you have booted a non-Athlon kernel on an Athlon process, user
> programs may get unexpected page faults." That's in init code, hopefully
> there is no critical size issue there, I assume, other than how large a
> kernel can be booted by the boot loader.
> 

How many bytes would that code require?

