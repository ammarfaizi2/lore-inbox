Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbUCBPco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUCBPco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:32:44 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:60547 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261673AbUCBPcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:32:42 -0500
Date: Tue, 02 Mar 2004 07:32:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <7190000.1078241563@[10.10.2.4]>
In-Reply-To: <20040302091048.GD3356@tpkurt.garloff.de>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random> <469160000.1077948622@[10.10.2.4]> <20040302091048.GD3356@tpkurt.garloff.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Feb 27, 2004 at 10:10:22PM -0800, Martin J. Bligh wrote:
>> Why is it 2.7GB with both 3:1 and 4:4 ... surely it can get bigger on 
>> 4:4 ???
> 
> You could use 3.7 on 4:4, but what's the point if you throw away the
> mapping constantly by flushing the TLB?

Normally, a bigger shm segment = higher performance. Throwing the TLB
away means lower performance. Depending on the workload, the tradeoff
could work out either way ... the only thing I've seen so far from
someone who has measured it was hints that 4/4 was faster in some 
situations ... we're trying to do some more runs to confirm / deny that.
Hopefully others will do the same ;-)

M.

