Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUEOWlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUEOWlM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 18:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUEOWlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 18:41:12 -0400
Received: from main.gmane.org ([80.91.224.249]:32165 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264763AbUEOWlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 18:41:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: walt <wa1ter@myrealbox.com>
Subject: Re: [OT] "bk pull" does not update my sources...?
Date: Sat, 15 May 2004 10:59:05 -0700
Message-ID: <c85lk9$96j$1@sea.gmane.org>
References: <40A51CFB.7000305@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-67-119-36-247.dsl.lsan03.pacbell.net
User-Agent: Mozilla/5.0 (X11; U; NetBSD i386; en-US; rv:1.6) Gecko/20040401
X-Accept-Language: en-us, en
In-Reply-To: <40A51CFB.7000305@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian wrote:
> hi,
> 
> being a beginner with Bitkeeper repositories i used to "clone" 
> bk://linux.bkbits.net/linux-2.5 to my disk, then did "bk -r get" (as 
> advised elsewhere) and do "bk pull" every now and then. but i noted the 
> following:
> 
> evil@sheep:/usr/src/linux-2.6-BK$ date
> Fr Mai 14 21:09:51 CEST 2004
> evil@sheep:/usr/src/linux-2.6-BK$ bk pull
> Pull bk://linux.bkbits.net/linux-2.5
>   -> file://usr/src/linux-2.6-BK
> Nothing to pull.
> evil@sheep:/usr/src/linux-2.6-BK$ head -n5 Makefile
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 6
> EXTRAVERSION =

This is correct.  Linus does not include the 'bk' in the 'extraversion' field.
Doing a 'bk pull' will always get you the most recent changes.  If you see the
'Nothing to pull' message then Linus has not posted any changes since the last
time you pulled.

Everything seems OK so far.

