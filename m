Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbVHJXbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbVHJXbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVHJXbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:31:51 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:49435 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S932602AbVHJXbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:31:50 -0400
Message-ID: <42FA8E65.7060008@pantasys.com>
Date: Wed, 10 Aug 2005 16:31:49 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Waychison <mikew@google.com>
CC: YhLu <YhLu@tyan.com>, linux-kernel@vger.kernel.org,
       "'discuss@x86-64.org'" <discuss@x86-64.org>
Subject: Re: 2.6.13-rc2 with dual way dual core ck804 MB
References: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB> <42FA8A4B.4090408@google.com>
In-Reply-To: <42FA8A4B.4090408@google.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Aug 2005 23:31:56.0531 (UTC) FILETIME=[B26A0430:01C59E03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
> This patch fixes an apparent race / lockup on our 2-way dual cores (when 
> applied against 2.6.12.3).  The machine was locking up after 
> "Initializing CPU#2".

the better ways is to use the patch from Eric that Andi posted to stable 
yesterday:

	http://x86-64.org/lists/discuss/msg06943.html

peter
