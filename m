Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbUB0K7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUB0K7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:59:54 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:20173 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261798AbUB0K7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:59:24 -0500
Message-ID: <403F230A.9030200@cyberone.com.au>
Date: Fri, 27 Feb 2004 21:59:22 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Sonika Sachdeva <sonikam@magnum.barc.ernet.in>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux scheduler Implementation details
References: <403F0B66.A7920233@magnum.barc.ernet.in> <403F0CD7.5080305@cyberone.com.au> <403F1204.32683547@magnum.barc.ernet.in> <403F16E2.2040706@cyberone.com.au> <403F2306.C51C75E8@magnum.barc.ernet.in>
In-Reply-To: <403F2306.C51C75E8@magnum.barc.ernet.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sonika Sachdeva wrote:

>I wonder if you could give me some hints to do fair approximations (to calculate
>execution time) for scheduling process?
>
>

Use a very simple model? Assume each runnable process gets equal
amount of the CPU.

I have no idea what you are trying to do or why, but I suspect
that the "simulator" you should be using is testing a running
kernel on a real machine. Very simple, very accurate.

