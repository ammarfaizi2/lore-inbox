Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWINO30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWINO30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWINO30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:29:26 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6856 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750799AbWINO30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:29:26 -0400
Date: Thu, 14 Sep 2006 08:28:38 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-reply-to: <fa.L0QDp0UiCRLE2HbZGTyQ/fbNwDU@ifi.uio.no>
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Message-id: <45096716.6050507@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7bit
References: <fa.IgLMAmyDbz1yS9bpHhwK3NW+uks@ifi.uio.no>
 <fa.qTCpjei55lhk7BvMUo3JQy7hYT8@ifi.uio.no>
 <fa.L0QDp0UiCRLE2HbZGTyQ/fbNwDU@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> BTW, all of the systems on which the problem shows up seem to be 64-bit.
> 
> If you can't reproduce it on a 32-bit system, some type casting may be wrong
> somewhere.
> 
> Greetings,
> Rafael

I'm getting this problem on a 32-bit system (see my report in reply to 
Andrew's 2.6.18-rc6-mm2 announcement). The EHCI driver won't suspend on 
the second attempt after bootup.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

