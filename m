Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUCLHAj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 02:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUCLHAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 02:00:39 -0500
Received: from 69-90-55-107.fastdsl.ca ([69.90.55.107]:12166 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id S261991AbUCLHAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 02:00:37 -0500
Message-ID: <4051615B.1030009@brad-x.com>
Date: Fri, 12 Mar 2004 02:06:03 -0500
From: Brad Laue <brad@brad-x.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ksoftirqd using mysteriously high amounts of CPU time
References: <Pine.LNX.4.21.0403111916570.3466-100000@linux08.ece.utexas.edu>
In-Reply-To: <Pine.LNX.4.21.0403111916570.3466-100000@linux08.ece.utexas.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmamouche, Youssef wrote:
  > Is there any way you could replace one of the network cards and 
test? I have a
> feeling it's a hardware problem where the interrupt never gets acknowledged in
> some situations - ksoftirq gets crazy.
> 
> you

This has occurred on any combination of the following six things:

Network cards:
Realtek 8139
SiS 900 Integrated
NE2K
3Com 3c905b

Motherboard chipsets:
ALI M1541
SiS 740
AMD 760

On the following kernel versions: 2.4.20, 2.4.21, 2.4.22, 2.4.23 (and 
-aa variants of 2.4.22, .23), 2.6.1, 2.6.2, 2.6.3.

It could well be a BIOS setting I'm habitually setting and forgetting 
about which is common to all motherboards, I'll have to check on that. 
Are there any of these I should be looking out for?
