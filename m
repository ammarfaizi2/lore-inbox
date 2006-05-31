Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbWEaWSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWEaWSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWEaWSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:18:40 -0400
Received: from terminus.zytor.com ([192.83.249.54]:35309 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751660AbWEaWSk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:18:40 -0400
Message-ID: <447E1636.8050300@zytor.com>
Date: Wed, 31 May 2006 15:18:30 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linux Kernel M/L <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make procfs obligatory except under CONFIG_EMBEDDED
References: <200605292207.k4TM722M027624@terminus.zytor.com> <447E161B.6060206@tmr.com>
In-Reply-To: <447E161B.6060206@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> H. Peter Anvin wrote:
>> From: H. Peter Anvin <hpa@zytor.com>
>>
>> This patch makes procfs non-optional unless EMBEDDED is set, just like
>> sysfs.  procfs is already de facto required for a large subset of
>> Linux functionality.
> 
> I have no objection, but I'm curious why this wasn't done long ago.
>

Probably because procfs predates CONFIG_EMBEDDED by many years, and noone really thought 
about it.  Either that or it was part of the "let's switch all of userspace to sysfs, 
overnight!" conspiracy.

	-hpa
