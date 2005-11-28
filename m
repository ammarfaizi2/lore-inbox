Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVK1Qmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVK1Qmb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 11:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVK1Qma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 11:42:30 -0500
Received: from zrtps0kn.nortelnetworks.com ([47.140.192.55]:39929 "EHLO
	zrtps0kn.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751298AbVK1Qm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 11:42:29 -0500
Message-ID: <438B3366.5070700@nortel.com>
Date: Mon, 28 Nov 2005 10:42:14 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mgross <mgross@linux.intel.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, vherva@vianova.fi, bunk@stusta.de,
       folkert@vanheusden.com, linux-kernel@vger.kernel.org
Subject: Re: capturing oopses
References: <20051122130754.GL32512@vanheusden.com> <20051126193358.GF22255@vianova.fi> <20051127204132.2b0d7406.rdunlap@xenotime.net> <200511280820.02473.mgross@linux.intel.com>
In-Reply-To: <200511280820.02473.mgross@linux.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Nov 2005 16:42:16.0034 (UTC) FILETIME=[B0BC5420:01C5F43A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mgross wrote:

> You know some platforms that perserve the memory above some addresses across 
> warm boots.  For such platforms, one could reserve a buffer in that area can 
> copy the sys log buffer to it on panic along with a bit pattern that could be 
> searched for upon the next boot.

I've worked on a few blades that had this.  Serial console wasn't going 
to be available in the field, so being able to just dump debug 
information to persistent memory was really nice.

Chris
