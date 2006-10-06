Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWJFANY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWJFANY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 20:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWJFANX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 20:13:23 -0400
Received: from mailfe09.tele2.it ([212.247.155.13]:58079 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932485AbWJFANV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 20:13:21 -0400
X-T2-Posting-ID: VkvTh9l7ZoGXxeaXnVjcEw==
X-Cloudmark-Score: 0.000000 []
Message-ID: <45259F9F.1050203@sssup.it>
Date: Fri, 06 Oct 2006 02:13:19 +0200
From: Tommaso Cucinotta <cucinotta@sssup.it>
User-Agent: Mozilla Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: In-kernel precise timing.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to know what is the preferrable way,
in a Linux kernel module, to get a notification
at a time in the future so to avoid as much as
possible unpredictable delays due to possible
device driver interferences. Basically, I would
like to use such a mechanism to preempt (also)
real-time tasks for the purpose of temporally
isolating them from among each other.

Is there any prioritary mechanism for specifying
kind of higher priority timers, to be served as
soon as possible, vs. lower priority ones, that
could be e.g. delayed to ksoftirqd and similar ?
(referring to 2.6.17/18, currently using add_timer(),
del_timer(), but AFAICS these primitives are more
appropriate for "timeout" behaviours, rather than
"precise timing" ones).

Thanks, regards,

    T.
