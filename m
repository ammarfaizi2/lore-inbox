Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWANNoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWANNoS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWANNoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:44:18 -0500
Received: from khc.piap.pl ([195.187.100.11]:36871 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030336AbWANNoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:44:17 -0500
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (compatibility)
References: <20060113195723.GB16166@tuxdriver.com>
	<20060113212605.GD16166@tuxdriver.com>
	<20060113213126.GF16166@tuxdriver.com>
	<20060113222054.GK16166@tuxdriver.com>
	<1137191590.2520.65.camel@localhost>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 14 Jan 2006 14:44:03 +0100
In-Reply-To: <1137191590.2520.65.camel@localhost> (Johannes Berg's message of "Fri, 13 Jan 2006 23:33:10 +0100")
Message-ID: <m3u0c69b6k.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> If you want the old userspace API to 'just work' you have to create one
> default wlan device at WiPHY init.

I'm not sure the old API is that important. This isn't something
programs (third party, kernel utils don't count) rely on. Most users
would switch to the new stack immediately anyway.

It could probably be a separate compatibility module, the core stack
probably don't have to know about it. The last to worry about I'd say.
-- 
Krzysztof Halasa
