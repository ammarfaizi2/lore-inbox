Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbTIAJOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 05:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTIAJOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 05:14:32 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:22220 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262786AbTIAJO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 05:14:28 -0400
Message-ID: <3F530E42.5010606@softhome.net>
Date: Mon, 01 Sep 2003 11:15:46 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
References: <qL3q.1Pm.3@gated-at.bofh.it> <qQ37.2q0.9@gated-at.bofh.it>
In-Reply-To: <qQ37.2q0.9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Sun, 31 Aug 2003, Dan Kegel wrote:
> 
>>Jamie Lokier <jamie () shareable ! org> wrote:
>>
>>>I'd love to be able to select which app _doesn't_ deserve the axe.
>>>I.e. not sshd, and then not httpd.
>>
>>I tried adding a hinting system that let the user
>>tweak the badness calculated by the OOM killer.
>>Didn't help.   No matter how I tried to protect
>>important processes, there was always a case where
>>the OOM killer ended up killing them anyway.
> 
> 
> Indeed.  You can't have completely fool-proof heuristics.
> 
> Then again, a heuristic is often better than killing
> syslogd at the first hint of trouble.
> 

    Best heuristics:
    # echo '/usr/sbin/sshd' >/proc/sys/vm/oom_exclude_list
    # echo '/usr/sbin/httpd' >/proc/sys/vm/oom_exclude_list

    Works 100% ;-)))

