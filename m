Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVCMW0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVCMW0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 17:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVCMW0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 17:26:25 -0500
Received: from stark.xeocode.com ([216.58.44.227]:11141 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261485AbVCMW0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 17:26:21 -0500
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: linux-kernel@vger.kernel.org, Greg Stark <gsstark@mit.edu>
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
References: <87u0ng90mo.fsf@stark.xeocode.com>
	<200503130152.52342.pmcfarland@downeast.net>
In-Reply-To: <200503130152.52342.pmcfarland@downeast.net>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 13 Mar 2005 17:26:12 -0500
Message-ID: <874qff89ob.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McFarland <pmcfarland@downeast.net> writes:

> On Saturday 12 March 2005 01:31 pm, Greg Stark wrote:
> > OSS Audio doesn't work properly for Quake3 in 2.6.10 but it worked in
> > 2.6.6. In fact I have the same problems in 2.6.9-rc1 so I assume 2.6.9 is
> > affected as well. This is with the Intel i810 drivers.
> 
> Why are you not using ALSA?

Well frankly because whenever I tried it it didn't work. The i810 drivers were
*completely* broken in the 2.6 kernel I original installed, 2.6.5 I think.

In any case I understood that Quake doesn't work with alsa drivers because it
depends on mmapped output which they don't support at all. Or something like
that. I gave up on them when I found OSS worked reliably.

Until someone broke it between 2.6.6 and 2.6.9. How likely are the 2.6.6
drivers to compile with 2.6.10? Is it worth trying?

-- 
greg

