Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVJRBJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVJRBJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 21:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVJRBJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 21:09:23 -0400
Received: from mail.dvmed.net ([216.237.124.58]:48017 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932100AbVJRBJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 21:09:22 -0400
Message-ID: <43544B3B.6020001@pobox.com>
Date: Mon, 17 Oct 2005 21:09:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dsaxena@plexity.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] RNG rewrite...
References: <20051015043120.GA5946@plexity.net> <4350DCB1.7010201@pobox.com> <20051016005341.GB5946@plexity.net> <43543455.4080206@pobox.com> <20051018010028.GA16005@plexity.net>
In-Reply-To: <20051018010028.GA16005@plexity.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> OK...I already did most of a rewrite keeping the driver in user space
> and added support for IXP4xx and OMAP but will look at the msr driver. 
> However, looking at the MPC85xx and the Alchemy MIPs parts with RNGs, 
> they have interrupt sources for error conditions so those need to be 
> in kernel...

If its in kernel space, there is no need to use the MSR driver.

	Jeff


