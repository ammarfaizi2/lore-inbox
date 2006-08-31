Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWHaIjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWHaIjV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWHaIjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:39:21 -0400
Received: from gw.goop.org ([64.81.55.164]:57235 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750779AbWHaIjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:39:21 -0400
Message-ID: <44F6A036.4090807@goop.org>
Date: Thu, 31 Aug 2006 01:39:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/8] Fix places where using %gs changes the usermode ABI.
References: <20060830235201.106319215@goop.org> <200608310936.36772.ak@suse.de> <44F69815.4070105@goop.org> <200608311013.03164.ak@suse.de>
In-Reply-To: <200608311013.03164.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> The first entry.S patch already threw 4 rejects or so.  I didn't try
> further. I guess I'll take it together with the rest of the paravirt
> stuff after the .19 merge.
>   

Oh, that's a conflict with the "cli -> DISABLE_INTERRUPTS" (etc) patch 
which is already in Andrews tree.  It should be pretty straightforward 
to wiggle around it.

    J
