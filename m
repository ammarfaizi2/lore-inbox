Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTDGTY7 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 15:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbTDGTY6 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 15:24:58 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:1458 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263600AbTDGTY6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 15:24:58 -0400
Date: Tue, 08 Apr 2003 07:33:26 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: PATCH: 2.5.66 incremental (#4: Discontiguous patches & Dynamic
	PageFlag Bitmap)
In-reply-to: <20030407130904.GB16919@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1049744005.19751.6.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1049685473.13733.4.camel@laptop-linux.cunninghams>
 <20030407130904.GB16919@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-08 at 01:09, Pavel Machek wrote:
> Drivers should never ever need to set themselves nosave....

Okay then. I'll make NoSave use the same scheme. I was mostly wondering
about shared memory video cards, but in that case it mostly just seems
to be a waste of time saving the pages - it doesn't cause problems.

> It contains the same double pointers and the same
> hard-limit-on-#pages-to-be-saved.

Sorry. I forgot about addressing that issue. I'll give one of your
suggestions a go when I find the time.

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

