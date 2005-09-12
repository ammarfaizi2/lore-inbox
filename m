Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVILSxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVILSxg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVILSxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:53:36 -0400
Received: from mail.dvmed.net ([216.237.124.58]:8096 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932145AbVILSxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:53:35 -0400
Message-ID: <4325CEAB.2050600@pobox.com>
Date: Mon, 12 Sep 2005 14:53:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com, cramerj@intel.com,
       jesse.brandeburg@intel.com, ayyappan.veeraiyan@intel.com,
       mchan@broadcom.com, davem@davemloft.net
Subject: Re: [patch 2.6.13 0/5] normalize calculations of rx_dropped
References: <09122005104858.332@bilbo.tuxdriver.com>
In-Reply-To: <09122005104858.332@bilbo.tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Some fixes to normalize how rx_dropped is calculated.  This is the
> product of a discussion on netdev on or about 18 August 2005 w/
> the subject '[RFC] stats: how to count "good" packets dropped by
> hardware?'
> 
> Patches for 3c59x, e1000, e100, ixgb, and tg3 to follow.

For e.g. e1000, are we sure that packets dropped by hardware are 
accounted elsewhere?

	Jeff



