Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbUBZT3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbUBZT2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:28:09 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:15492 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262943AbUBZT1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:27:05 -0500
Message-ID: <403E487B.8020707@matchmail.com>
Date: Thu, 26 Feb 2004 11:26:51 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Nico Schottelius <nico-kernel@schottelius.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: another hard disk broken or xfs problems?
References: <20040225220051.GA187@schottelius.org> <20040225223428.GD640@frodo> <20040225234944.GD187@schottelius.org> <20040226032741.GB1177@frodo> <20040226082551.GA218@schottelius.org> <20040226204615.A481868@wobbly.melbourne.sgi.com>
In-Reply-To: <20040226204615.A481868@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
> On Thu, Feb 26, 2004 at 09:25:51AM +0100, Nico Schottelius wrote:
>>And btw, do all filesystem drivers behave in this way, printing internal
>>errors and displaying call traces when they find errors in the
>>filesystem?
> 
> 
> No, not all filesystem behave this way.  And it is configurable
> in XFS; if you don't want this to happen, you can switch it off
> via the sysctl/procfs interface - see the "error_level" section
> in Documentation/filesystems/xfs.txt.

I like this idea.

Is it just calling dump_stack() based on error level?
