Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbTFLXEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTFLXEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:04:39 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:41879 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S265058AbTFLXDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:03:45 -0400
Date: Fri, 13 Jun 2003 11:20:34 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: The disappearing sys_call_table export.
In-reply-to: <Pine.LNX.4.44.0305140234110.32259-100000@marcellos.corky.net>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: Ahmed Masud <masud@googgun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1055459980.2388.14.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.44.0305140234110.32259-100000@marcellos.corky.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2003-05-14 at 11:58, Yoav Weiss wrote:
> Actually, I forgot that swsusp is now included.  I haven't tried it in a
> while.  Anyone knows if its stable enough to start playing with encrypting
> it ?

Sorry for the slow response - I guess Pavel didn't notice your question
either. In it's current form in the 2.5 kernel, swsusp is stable enough
to try encrypting the data. However you might want to wait as the 2.4
version is nearly at its 1.0 release, and the plan is for me to then
start submitting a whole swag of patches that will make the code much
more feature complete. The 2.4 code includes support for compressing the
image; I guess we'd want to hook encryption in at the same point (it
will use BIO calls, not the swap read/write routines).

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

