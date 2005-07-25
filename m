Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVGYPMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVGYPMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 11:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVGYPMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 11:12:25 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:16053 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261308AbVGYPMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 11:12:24 -0400
Message-ID: <42E50159.6050901@nortel.com>
Date: Mon, 25 Jul 2005 11:12:25 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <bert.hubert@netherlabs.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: do_gettimeofday monotony?
References: <20050724182617.GA15707@outpost.ds9a.nl>
In-Reply-To: <20050724182617.GA15707@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> Is do_gettimeofday supposed to be monotonous?

Nope.

 > I'm seeing time go backward by tiny amounts, and then progressing.

Are you running NTP?  Corrections could cause this.

> Is there another monotonous clock in the kernel that doesn't wrap (all
> that often)? Doesn't really need to be wall time.

clock_gettime()

Chris
