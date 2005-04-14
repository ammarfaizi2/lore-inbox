Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVDNP3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVDNP3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 11:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVDNP3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 11:29:12 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:45548 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261525AbVDNP3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 11:29:10 -0400
Message-ID: <425E8C3D.3090006@nortel.com>
Date: Thu, 14 Apr 2005 09:29:01 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: iproute/iptables best?
References: <200504132335.12324.gene.heskett@verizon.net> <20050414065404.GA10880@outpost.ds9a.nl>
In-Reply-To: <20050414065404.GA10880@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> On Wed, Apr 13, 2005 at 11:35:12PM -0400, Gene Heskett wrote:
> 
>>How can we make the reply to an action go back out through the route 
>>it came in on?
> 
> Sometimes Linux can't (and shouldn't) figure out the "right" interface. In
> this case, you need policy routing:

Yep.  iproute2 with policy routing should handle it.  I've been using it 
for about 4 years now.

Chris
