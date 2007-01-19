Return-Path: <linux-kernel-owner+w=401wt.eu-S932799AbXASApm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbXASApm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932801AbXASApm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:45:42 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39037 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799AbXASApl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:45:41 -0500
Message-ID: <45B014A4.8030801@zytor.com>
Date: Thu, 18 Jan 2007 16:45:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alexey Dobriyan <adobriyan@openvz.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       devel@vger.kernel.org
Subject: Re: [PATCH] rdmsr_on_cpu, wrmsr_on_cpu
References: <20070118144527.GA6021@localhost.sw.ru> <200701191021.16706.ak@suse.de> <45B00588.3010207@zytor.com> <200701191140.59612.ak@suse.de>
In-Reply-To: <200701191140.59612.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 19 January 2007 10:40, H. Peter Anvin wrote:
> 
>> It would, but rather than having the paravirtualization interfaces
>> duplicate out of control, we could/should implement the less generic
>> features in terms of the more generic, above the pvz layer.
> 
> I can't see any Hypervisors ever allowing those weird MSRs, so
> for paravirtualization it is probably better to just disable then.
> 

Don't assume they're going to be "weird."  Intel, in particular, is 
notorious in forgetting what they have already documented as architectural.

	-hpa
