Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbTDETQt (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 14:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbTDETQt (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 14:16:49 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:45300 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S262624AbTDETQs (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 14:16:48 -0500
Date: Sun, 06 Apr 2003 07:25:12 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: PATCH: Fixes for ide-disk.c
In-reply-to: <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1049570711.3320.2.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1049527877.1865.17.camel@laptop-linux.cunninghams>
 <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2003-04-06 at 04:46, Alan Cox wrote:
> Drive->blocked is a single bit field. Its not a counting lock. Either
> we are blocked or not.

Okay. We need a different solution then, but the problem remains - the
driver can get multiple, nexted calls to block and unblock. Can it
become a counting lock?

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

