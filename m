Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270877AbTG0QWR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 12:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270875AbTG0QWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 12:22:17 -0400
Received: from mail-07.iinet.net.au ([203.59.3.39]:60677 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S270874AbTG0QUg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 12:20:36 -0400
Message-ID: <3F23FD2F.6030000@ii.net>
Date: Mon, 28 Jul 2003 00:26:23 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030724 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
References: <200307280112.16043.kernel@kolivas.org>
In-Reply-To: <200307280112.16043.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Here is a fairly rapid evolution of the O*int patches for interactivity thanks
> to Ingo's involvement.
> 
> Changes:
> I've put in some defines to clarify where the numbers for MAX_SLEEP_AVG come 
> from now, rather than the number being magic. In the process it increases MSA 
> every so slightly so that an average task that runs a full timeslice (102ms) 
> will drop exactly one priority in that time.
> 
> I've incorporated Ingo's fix for scheduling latency in a form that works for 
> my patch, along with the other minor tweaks.
> 
> The parent and child sleep avg on forking is set to just on the priority bonus 
> value with each fork thus keeping their bonus the same but making them very 
> easy to tip to a lower priority.
> 
> A tiny addition to ensure any task that runs gets charged one tick of 
> sleep_avg.
> 
> This patch is against 2.6.0-test1-mm2 patched up to O9int. An updated
> O9int with layout corrections was posted on my website. A full O10int patch
> against 2.6.0-test1 is available on my website.
> 
> Con
> 
> http://kernel.kolivas.org/2.5
> 
[snip]

Anyone who has been holding back on trying these patches out should try 
this one, it's _very_ smooth for me here. Thank you Con & Ingo!



