Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWJRQpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWJRQpH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWJRQpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:45:07 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:6663 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP
	id S1161232AbWJRQpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:45:01 -0400
Message-ID: <45365A0B.5030306@xs4all.nl>
Date: Wed, 18 Oct 2006 18:44:59 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 w/ GPS time source: worse performance
References: <4534F5F7.8020003@xs4all.nl> <1161103616.2919.70.camel@mindpipe>	 <45364631.9070805@xs4all.nl> <1161189384.15860.85.camel@mindpipe>
In-Reply-To: <1161189384.15860.85.camel@mindpipe>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2006-10-18 at 17:20 +0200, Udo van den Heuvel wrote:
>> Lee Revell wrote:
>>> On Tue, 2006-10-17 at 17:25 +0200, Udo van den Heuvel wrote:
>>>> Why does a GPS as time source (with ntpd) perform so much worse with 2.6.18?
>>> Um... you don't give nearly enough information to even begin to know
>>> what you're talking about.
>> No one here with a vague idea about the cause for the bad performance?
>> I am sure I not the only one experiencing this.
> 
> No, the issue is that a one-sentence bug report is not helpful.  You
> don't give enough information to debug it.  Kernel config, steps to
> reproduce, etc, etc.
> 
> Please look at LKML archives for some examples of the type of bug report
> that does get a response.

Get the latest kernel.
Compile for your system
Get ntpd.
Configure for your PPS/NMEA source.
Run ntpd.
Watch performance.
Repeat watching of performance.

It is not a crash. Not an oops.
It is stuff that is visible by watching ntpq -pn output, by letting mrtg
graph stuff, etc. Watch the offset and jitter collumns.
Check /usr/sbin/ntpdc -c kerninfo output. Graph that stuff.
Over the monhts you see changes. Some of them you can explain. Some you
can't.

I can understand this is not you everyday bug but this *is* an issue.

