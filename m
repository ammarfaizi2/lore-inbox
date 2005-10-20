Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVJTXje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVJTXje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVJTXje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:39:34 -0400
Received: from mail.dvmed.net ([216.237.124.58]:6832 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964807AbVJTXjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:39:33 -0400
Message-ID: <43582AA7.4080503@pobox.com>
Date: Thu, 20 Oct 2005 19:39:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <xslaby@fi.muni.cz>
CC: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jiri Benc <jbenc@suse.cz>
Subject: Re: Wifi oddness [Was: Re: 2.6.14-rc4-mm1]
References: <20051016154108.25735ee3.akpm@osdl.org> <20051019184935.E8C0B22AEB2@anxur.fi.muni.cz> <20051019184935.E8C0B22AEB2@anxur.fi.muni.cz> <20051020210224.B9D4A22AEB2@anxur.fi.muni.cz>
In-Reply-To: <20051020210224.B9D4A22AEB2@anxur.fi.muni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> But here is a problem ieee->perfect_rssi and ieee->worst_rssi is 0 and 0, as
> you mentioned -- division by zero...
> 
> It seems, that it is pulled from your tree, Jeff. Any ideas?
> 
> thanks,

When it was pulled?  Here is the latest patch touching the code in 
question...

Author: Jiri Benc <jbenc@suse.cz>
Date:   Mon Oct 10 19:16:53 2005 +0200

     [PATCH] ieee80211: division by zero fix

     This fixes division by zero bug in ieee80211_wx_get_scan().

     Signed-off-by: Jiri Benc <jbenc@suse.cz>
     Signed-off-by: Jeff Garzik <jgarzik@pobox.com>


