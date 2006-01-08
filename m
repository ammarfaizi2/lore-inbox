Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161199AbWAHVEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbWAHVEs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWAHVEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:04:48 -0500
Received: from mx03.stofanet.dk ([212.10.10.13]:16821 "EHLO mx03.stofanet.dk")
	by vger.kernel.org with ESMTP id S932773AbWAHVEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:04:48 -0500
Message-ID: <43C17E50.4060404@stud.feec.vutbr.cz>
Date: Sun, 08 Jan 2006 22:04:16 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Knecht <markknecht@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.15-rt2 - repeatable xrun - no good data in trace
References: <5bdc1c8b0601081252x59190f1ajcb5514364d78a4e@mail.gmail.com>
In-Reply-To: <5bdc1c8b0601081252x59190f1ajcb5514364d78a4e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Knecht wrote:
> Hi,
>    I did run across a way that I can create a repeatable xrun on my
> AMD64 machine by burning a CD in k3b while Jack is running.
> Unfortunately I do not see any good trace data in dmesg when I do it.

Maybe your cdrecord is running with realtime priority higher than Jack?
Michal
