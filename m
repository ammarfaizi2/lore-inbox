Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUJSVay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUJSVay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269891AbUJSVKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:10:23 -0400
Received: from knorkaan.xs4all.nl ([213.84.240.34]:6925 "EHLO
	knorkaan.xs4all.nl") by vger.kernel.org with ESMTP id S269930AbUJSVDq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:03:46 -0400
Date: Tue, 19 Oct 2004 23:03:40 +0200 (CEST)
From: Jerome Borsboom <j.borsboom@erasmusmc.nl>
To: johnstul@us.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: process start time set wrongly at boot for kernel 2.6.9
Message-ID: <Pine.LNX.4.61.0410192254390.6523@knorkaan.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>How reproducible is this? Are the correct and incorrect time values 
>always off by the same amount?
>
>Are you running NTP? I'm curious if you are changing your system time 
>during boot.
>
>thanks
>-john

At each boot, the time of the first processes seems to be off 1 hour and 
11 minutes. Another system shows the same symptoms but with different 
values.

I am setting the time during boot with ntp, but the start time seems to 
change from incorrect to correct before I even run ntp.

Jerome
