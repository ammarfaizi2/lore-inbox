Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUAYBxp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 20:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUAYBxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 20:53:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12780 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263452AbUAYBxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 20:53:42 -0500
Message-ID: <40132199.9090200@pobox.com>
Date: Sat, 24 Jan 2004 20:53:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 tg3 DMA engine test failure
References: <20040124013614.GB1310@colo.lackof.org> <20040123.210023.74723544.davem@redhat.com> <20040124073032.GA7265@colo.lackof.org> <20040123.233241.59493446.davem@redhat.com> <4012E071.2080704@pobox.com> <20040125014859.GD16272@colo.lackof.org>
In-Reply-To: <20040125014859.GD16272@colo.lackof.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Sat, Jan 24, 2004 at 04:15:29PM -0500, Jeff Garzik wrote:
> 
>>David,
>>
>>There were two separate components to Grant's patch (hint ggg... split 
>>up your patches).
> 
> 
> you are right - sorry.
> I'll break it down when I submit patches for RHEL3/ia64.
> (Actually, I'll only submit the changes david accepted).
> 
> I had already rejected some other issues broadcom wanted me to address.

Hey, feel free to address as many issues as you would like!  :)


>>What do you think about GRC-resets-sub-components part?
>>That appears valid (and probably wise) to me, but correct me if I'm wrong...
> 
> 
> BTW, next on the horizon is removing FTQ reset.
> I'm told the FTQ reset is NOT performed by the Tru64 (Alpha/Unix) driver
> and Broadcom is testing that with the next release of bcm5700 now.

We just went through this with Broadcom, when David applied fixes 
related to ASF...  rather than what Broadcom is _testing_, though, I'm 
more interested to know if GRC resets FTQ's according to the hardware 
engineers?

	Jeff



