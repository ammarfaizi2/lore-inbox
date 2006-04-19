Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWDSXhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWDSXhk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWDSXhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:37:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24485 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751241AbWDSXhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:37:39 -0400
Date: Wed, 19 Apr 2006 19:37:29 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: =?iso-8859-2?Q?Pawe=B3_Kowalski?= <pk@protest.com.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: problem with cache size
In-Reply-To: <Pine.LNX.4.58.0604192134240.9362@filer.protest.com.pl>
Message-ID: <Pine.LNX.4.63.0604191936310.11063@cuia.boston.redhat.com>
References: <Pine.LNX.4.58.0604192134240.9362@filer.protest.com.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Pawe? Kowalski wrote:

> I'm using RedHat Linux 7.2 with compiled kernel 2.4.25.
> My serwer has one cpu "Intel(R) Pentium(R) 4 CPU 3.20GHz" with HT flag so
> there are two processors in cpuinfo.
> The processor has 2MB cache but `cat /proc/cpuinfo` shows only 16KB.

That's cosmetic.  The CPU will still use all the cache,
since this is controlled entirely by hardware and the
OS has no influence.

> When I try to use 2.4.17 kernel, there is 2048KB cache but cpuinfo shows
> only one cpu :)
> I don't know where I should send my question, maybe You could help me.
> I'll be very thankful for any answer.

If you have the time, you could try to find the changeset
that caused the problem and send Marcelo a patch ;)

-- 
All Rights Reversed
