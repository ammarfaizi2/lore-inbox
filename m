Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTETUA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 16:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbTETUA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 16:00:27 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:64710 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S261151AbTETUA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 16:00:26 -0400
Date: Wed, 21 May 2003 08:10:00 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
In-reply-to: <20030520171759.GR32559@Synopsys.COM>
To: alexander.riesen@synopsys.COM
Cc: Milton Miller <miltonm@bga.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mikpe@csd.uu.se
Message-id: <1053461400.2055.7.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <3ECA05FA.6090008@gmx.net>
 <200305201634.h4KGY9VJ049544@sullivan.realtime.net>
 <20030520170054.GQ32559@Synopsys.COM> <20030520171759.GR32559@Synopsys.COM>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't the first time crashes have been seen suspending when hardly
any memory has been used. With the 2.4 swsusp project, we've seen
crashes appear when trying to suspend with init=/bin/bash that don't
appear when more memory has been used. Perhaps there's a common issue
here.

Regards,

Nigel

On Wed, 2003-05-21 at 05:17, Alex Riesen wrote:
> It is harder to trigger, but possible.
> I booted with init=/bin/bash. Than I started this
> find / -type f -fprint /dev/stderr -print | xargs cat > /dev/null
> and began going in suspend mode and back.
> 
> At some point it broke with oops above.
> 
> -alex

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

