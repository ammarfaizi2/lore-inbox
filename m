Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWBEUyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWBEUyH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 15:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWBEUyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 15:54:07 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:16039 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750718AbWBEUyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 15:54:06 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43E6650C.1090407@s5r6.in-berlin.de>
Date: Sun, 05 Feb 2006 21:50:20 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [RFC 4/4] firewire: add mem1394
References: <1138919238.3621.12.camel@localhost>	<1138920185.3621.24.camel@localhost>	<20060205004327.78926498.akpm@osdl.org> <p73lkwplfw8.fsf@verdi.suse.de>
In-Reply-To: <p73lkwplfw8.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.43) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> BenH's firescope tool does this already using raw1394
> (I have it working now on x86-64 too). I dont quite see the point
> of adding another kernel driver for it though. This can be all
> done fine in userspace.

The point is to provide an interface like /dev/mem in order to use a 
wider range of debug/ forensics/ hacker tools than specialized 
libraw1394 clients. Sure enough, the benefit is small, but so is this 
driver's code footprint.
-- 
Stefan Richter
-=====-=-==- --=- --=-=
http://arcgraph.de/sr/
