Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268919AbUJKNSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268919AbUJKNSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUJKNSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:18:30 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:27050 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268919AbUJKNSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:18:23 -0400
Message-ID: <416A881D.9080100@kolivas.org>
Date: Mon, 11 Oct 2004 23:18:21 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Staircase 8.I cpu scheduler
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current staircase cpu scheduler is available for 2.6.9-rc4:

http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-rc4/2.6.9-rc4_to_staircase8.I.diff

and for 2.6.9-rc4-mm1:

http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1_to_staircase8.I.diff

Numerous problems from keeping in sync have been resolved, 
microoptimisations, sanity checks and lots of comments were added, and 
preempted tasks are now placed at the head of their queue to continue 
next after preemption. cpu accounting has been yet again revisited and 
simplified as much as possible after the instability of earlier 8.x 
versions, bringing back stability.

Cheers,
Con
