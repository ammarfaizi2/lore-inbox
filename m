Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbTDOFse (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 01:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTDOFsd (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 01:48:33 -0400
Received: from ca-fulrtn-cuda2-c6a-113.anhmca.adelphia.net ([68.66.9.113]:43661
	"EHLO shrike.mirai.cx") by vger.kernel.org with ESMTP
	id S264298AbTDOFsd (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 01:48:33 -0400
Message-ID: <3E9B9FF7.2020803@tmsusa.com>
Date: Mon, 14 Apr 2003 23:00:23 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67-mm3 report
References: <3E9B400D.60403@tmsusa.com> <20030414174434.07a2268a.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>jjs <jjs@tmsusa.com> wrote:
>
>>The symptom here is that running the "ruptime" command on an -mm3
>>box shows all hosts down -
>>
>>Interestingly, the other hosts are getting the rwho broadcasts from
>>the -mm3 box, but the -mm3 box is unable to process rwho broadcasts,
>>including  it's own -
>>    
>>
>
>Does it use IP multicast?  There were recent changes in there. 
>CONFIG_IP_MULTICAST may need to be fiddled with.
>

It only uses normal ip broadcast AFAIK -
I don't see a solaris-like "-m" option in the
linux man page for rwhod -

Joe

