Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWETDzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWETDzQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 23:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWETDzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 23:55:15 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:32228 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S932495AbWETDzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 23:55:14 -0400
Date: Sat, 20 May 2006 04:54:52 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: dummy@vaio.testbed.de
To: Mel Gorman <mel@csn.ul.ie>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: SCSI ABORT with 2.6.17-rc4-mm1
In-Reply-To: <Pine.LNX.4.64.0605200133040.12335@skynet.skynet.ie>
Message-ID: <Pine.NEB.4.64.0605200450290.4276@vaio.testbed.de>
References: <62331.192.18.1.5.1148071784.squirrel@housecafe.dyndns.org>
 <20060519141032.23de6eee.akpm@osdl.org> <20060519225746.GA11883@skynet.ie>
 <20060519163038.7236c8e3.akpm@osdl.org> <Pine.LNX.4.64.0605200133040.12335@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2006, Mel Gorman wrote:
> Obviously. One option is to back out 
> have-x86_64-use-add_active_range-and-free_area_init_nodes.patch and see what 
> happens on Christian's machine.

I've disabled CONFIG_PM and backed out above patch (from -rc4-mm1), but 
sadly, the error persists:

http://nerdbynature.de/bits/2.6.17-rc4-mm1/no-CONFIG_PM/
http://nerdbynature.de/bits/2.6.17-rc4-mm2.x/no-CONFIG_PM/
(the first one with the said patch backed out)

Thanks for your ideas,
Christian.
-- 
There's another way to survive.  Mutual trust -- and help.
 		-- Kirk, "Day of the Dove", stardate unknown
