Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271134AbUJUX6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271134AbUJUX6v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271131AbUJUX5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:57:01 -0400
Received: from dsl017-059-236.wdc2.dsl.speakeasy.net ([69.17.59.236]:17615
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S271134AbUJUXwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:52:08 -0400
Date: Thu, 21 Oct 2004 19:58:18 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.9-rc?] long pause after IDE detection
Message-ID: <20041021235818.GE24703@kurtwerks.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <20041021220438.GA13864@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021220438.GA13864@zombie.inka.de>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.9
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 12:04:38AM +0200, Eduard Bloch took 159 lines to write:
> Hello,
> 
> I have a strange problem since 2.6.9-rc3 or so: after the first two IDE
> interfaces of my laptop have been detected, it waits for about 30
> seconds to continue. It does simply nothing in the meantime. This began
> with 2.6.9-rc3 or maybe earlier but I do not have such problem with
> 2.6.8.1. I also get the attached output. I have no idea how it gets the
> idea that there are ide2..5. I will also attach some hardware data.  It
> is a Toshiba laptop, Satellite Pro 2100.

Adding "ide2=noprobe ide3=noprobe ide4=noprobe ide5=noprobe" to my boot
parameters stopped the additional probes on interfaces I don't have.

Kurt
-- 
If you think the United States has stood still, who built the largest
shopping center in the world?
	-- Richard M. Nixon
