Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbTDFUvK (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTDFUvK (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:51:10 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:8592 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263080AbTDFUvJ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 16:51:09 -0400
Date: Mon, 07 Apr 2003 08:59:34 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: PATCH: Fixes for ide-disk.c
In-reply-to: <1049641400.963.18.camel@dhcp22.swansea.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1049662773.3200.16.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1049527877.1865.17.camel@laptop-linux.cunninghams>
 <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk>
 <1049570711.3320.2.camel@laptop-linux.cunninghams>
 <1049641400.963.18.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. I just figured that if there are two (say) calls to suspend a
driver, there should be two calls to resume it before it actually is
resumed. Does the spec say anything about how multiple suspends &
resumes should be handled?

Regards,

Nigel

> Blocked is a binary power management described state, its not a lock.
> What are you actually trying to do ?
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

