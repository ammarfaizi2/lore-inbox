Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbVIISWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbVIISWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 14:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbVIISWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 14:22:53 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:28633 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S1030319AbVIISWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 14:22:52 -0400
Message-ID: <4321D2F8.5020500@lanl.gov>
Date: Fri, 09 Sep 2005 12:22:48 -0600
From: Josip Loncaric <josip@lanl.gov>
Organization: LANL
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: PROBLEM: sk98lin misbehaves with D-Link DGE-530T which doesn't
 have readable VPD
References: <42EE9721.5000501@lanl.gov>	<4321CB39.3080206@lanl.gov> <20050909110550.3fb82d36@localhost.localdomain>
In-Reply-To: <20050909110550.3fb82d36@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Fri, 09 Sep 2005 11:49:45 -0600
> Josip Loncaric <josip@lanl.gov> wrote:
> 
> 
>>Driver sk98lin makes repeated attempts to read VPD even after the first 
>>VpdInit() fails.  This is wrong.
> 
> Now that skge is in 2.6.13, perhaps the proper thing to do is to take
> DGE-530T out of the PCI table for sk98lin?

Sounds good to me -- since your skge works fine -- but there are lots of 
people with Marvell GBE on the motherboard that are in the same 
predicament.  The PCI table for sk98lin could be pruned further (in 
favor of skge).

Sincerely,
Josip
