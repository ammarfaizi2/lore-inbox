Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVJSMSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVJSMSr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVJSMSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:18:47 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:38538 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750833AbVJSMSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:18:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=DeJ+RsSjNQ6+JqI+1n/2582o8Q+l2UlCg9U8l7UfiY8DrI12WHqLJA5O5Ew6Xq8p75mLFz7yBxHICEPBIUBi0pPU+0RsGsEGWtMvvhCffVtl0ADGM5i0HydYV+sIhiMzuRv2jHQxM8zJemoymtAkW/eqfIuleiLZK7WuEhnQMtw=
Message-ID: <4356399A.9060902@gmail.com>
Date: Wed, 19 Oct 2005 21:18:34 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-2.6-block:master] overview of soon-to-be-posted patches
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, Jens.

  As requested, I've regenerated dispatch queue and ordered patchset and 
will soon post 18 patches.  All patches are against the current master 
of linux-2.6-block:master (3d80636a0d5f056ffc26472d05b6027a7a9f6e1c).

patch #1	: fix-elevator_find.  remove try_module_get race in
		  elevator_find.
patch #2-6	: generic dispatch queue patchset.
patch #7	: reimplement-elevator-switch.  reimplements elevator
		  switch using generic dispatch queue.
patch #8-17	: ordered reimplementation patchset

  Patches should be applied in above order.  I proof-read changes and 
tested things to make sure changes made to the tree since the last 
posting doesn't break anything.  Well, it seems okay and works for me.

  Thanks.

-- 
tejun
