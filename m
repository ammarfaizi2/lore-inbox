Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267776AbUG3SM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267776AbUG3SM3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUG3SM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:12:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4061 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267776AbUG3SKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:10:51 -0400
Message-ID: <410A8F17.8070401@pobox.com>
Date: Fri, 30 Jul 2004 14:10:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: List of pending v2.4 kernel bugs
References: <20040720142640.GB2348@dmt.cyclades> <20040721112336.GA9537@k3.hellgate.ch> <20040730155613.GD2748@logos.cnet> <410A8077.7020308@pobox.com> <20040730172939.GA24235@k3.hellgate.ch>
In-Reply-To: <20040730172939.GA24235@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> On Fri, 30 Jul 2004 13:08:07 -0400, Jeff Garzik wrote:
> As I have pointed out before, I verified for Linux 2.6 that without
> the patch, multicasting worked on x86 but not on ppc, and that with
> the patch multicasting did work on both platforms. If in 2.4 you prefer
> stability over fixes for bugs nobody complained about that's fine by
> me, though.

> I am more concerned with the remaining drivers that at first glance
> looked like they had the same problem (atp, winbond, tulip_core) in
> 2.6. Did anyone ever test these, or try the patches I posted? The only
> feedback I remember was on typhoon, which looked okay to me and indeed
> turned out to work.

Those are precisely the changes I am talking about.  I have no idea if 
anybody has verified them, and thus, I don't want to push to mainline 
until someone does.

Since you verified the via-rhine change, it is OK to merge.

	Jeff


