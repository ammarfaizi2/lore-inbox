Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUEVWNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUEVWNy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 18:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUEVWNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 18:13:54 -0400
Received: from pxy7allmi.all.mi.charter.com ([24.247.15.58]:40168 "EHLO
	proxy7-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S261706AbUEVWNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 18:13:52 -0400
Message-ID: <40AFD09E.8060607@quark.didntduck.org>
Date: Sat, 22 May 2004 18:13:50 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vadim Lobanov <vadim@cs.washington.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: modprobe_path & hotplug_path
References: <20040522150054.R26485-100000@attu1.cs.washington.edu>
In-Reply-To: <20040522150054.R26485-100000@attu1.cs.washington.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov wrote:
> Hi,
> 
> Just wanted to inquire about something curious that I saw in the kernel 
> subtree...
> 
> Currently modprobe_path and hotplug_path are declared as "char ...[256]", 
> though it seems to me (unless I've missed something), that they only ever 
> hold "/sbin/modprobe" and "/sbin/hotplug", respectively. Any reason why we 
> couldn't simply declare them "char ...[]", and let them be sized 
> appropriately?
> 
> Let me know if I've missed something.
> 
> Thanks,
> Vadim Lobanov

Because userspace can change them.

--
				Brian Gerst
