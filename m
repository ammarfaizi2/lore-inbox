Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755967AbWKVRLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967AbWKVRLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755990AbWKVRLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:11:43 -0500
Received: from tapsys.com ([72.36.178.242]:8648 "EHLO tapsys.com")
	by vger.kernel.org with ESMTP id S1755967AbWKVRLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:11:43 -0500
Message-ID: <456484C9.6080205@madrabbit.org>
Date: Wed, 22 Nov 2006 09:11:37 -0800
From: Ray Lee <ray-lk@madrabbit.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, Dan Williams <dcbw@redhat.com>,
       Broadcom Linux <bcm43xx-dev@lists.berlios.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC/T: Trial fix for the bcm43xx - wpa_supplicant -	NetworkManager
 deadlock
References: <4561DBE0.2060908@lwfinger.net> <45628C05.405@madrabbit.org> <45633FF8.6010209@lwfinger.net> <1164133962.3631.14.camel@johannes.berg> <1164134201.3631.16.camel@johannes.berg> <45634A4A.1040909@lwfinger.net>
In-Reply-To: <45634A4A.1040909@lwfinger.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Finger wrote:
> I'm going to install NM on my system to see if I can trigger the problem
> with lockdep enabled.

I have had lockdep enabled both times, and it didn't whinge about anything.
I'm wondering if that's because events/0 is doing delayed work on behalf of
bcm43xx (it was in both traces as well as NM and wpa_supplicant).

Ray
