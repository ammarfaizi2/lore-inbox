Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTJWIMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 04:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTJWIMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 04:12:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36506 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261695AbTJWIMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 04:12:38 -0400
Date: Mon, 20 Oct 2003 14:15:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend with 2.6.0-test7-mm1
Message-ID: <20031020121525.GQ1659@openzaurus.ucw.cz>
References: <3F93AF7F.9030206@2gen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F93AF7F.9030206@2gen.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I've seen this, too.  Try "sleep 1; echo -n standby > 
> >/sys/power/state".  I theory I thought of, is that the system 
> >suspends before you have
> >time to release the enter key, and the key release triggers a wakeup.
> 
> Ok, tried it, doesn't help (exactly the same behaviour)...any more 
> suggestions?

Try -test8 with echo 4 > /proc/acpi/sleep
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

