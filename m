Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031306AbWKUStz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031306AbWKUStz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031308AbWKUStz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:49:55 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:54469 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1031306AbWKUStz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:49:55 -0500
Message-ID: <45634A4A.1040909@lwfinger.net>
Date: Tue, 21 Nov 2006 12:49:46 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: Ray Lee <ray-lk@madrabbit.org>, Dan Williams <dcbw@redhat.com>,
       Broadcom Linux <bcm43xx-dev@lists.berlios.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC/T: Trial fix for the bcm43xx - wpa_supplicant -	NetworkManager
 deadlock
References: <4561DBE0.2060908@lwfinger.net> <45628C05.405@madrabbit.org> <45633FF8.6010209@lwfinger.net> <1164133962.3631.14.camel@johannes.berg> <1164134201.3631.16.camel@johannes.berg>
In-Reply-To: <1164134201.3631.16.camel@johannes.berg>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg wrote:
> On Tue, 2006-11-21 at 19:32 +0100, Johannes Berg wrote:
> 
>> I don't think this is the right thing to do.
> 
> Or put differently, this won't fix the problem if that "something:
> that's triggering the deadlock happens while you're in the locked
> section.

I'm going to install NM on my system to see if I can trigger the problem with lockdep enabled.

Larry
