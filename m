Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266046AbUALEuX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 23:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266047AbUALEuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 23:50:23 -0500
Received: from 12-211-66-61.client.attbi.com ([12.211.66.61]:37504 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S266046AbUALEuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 23:50:22 -0500
Message-ID: <4002278A.7030808@comcast.net>
Date: Sun, 11 Jan 2004 20:50:18 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040111
X-Accept-Language: en-us
MIME-Version: 1.0
To: mail@jan-ischebeck.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm2: BUG in kswapd?
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew,
> 
> After 24 hours running 2.6.1-mm2 I got the following BUG in kswapd:
> 
<snip>

I'm seeing this also. Started in 2.6.1-mm1 with the debug change to
list.h  I've got a fairly repeatable case I can create:

Bring computer up and let it run a while - 1 hour or so. Start rsync
process to backup system. This seems to trip it almost every time. If I
boot directly into runlevel 1 and immediately do the same rsync backup,
it will work fine.

When I first hit it, I had preemption enabled. I re-compiled without it,
and it made no difference.

-Walt




