Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVAJSwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVAJSwe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVAJSvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:51:17 -0500
Received: from colin2.muc.de ([193.149.48.15]:34322 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262301AbVAJSpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:45:22 -0500
Date: 10 Jan 2005 19:45:20 +0100
Date: Mon, 10 Jan 2005 19:45:20 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: jamesclv@us.ibm.com, Mikael Pettersson <mikpe@csd.uu.se>,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050110184520.GB74665@muc.de>
References: <3174569B9743D511922F00A0C943142307291394@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142307291394@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 10:48:40AM -0800, YhLu wrote:
> James,
> 
> I'm working on add amd dual core LinuxBIOS support to our MB. So I can
> change the apic id as I want.
> 
> When I lift the apic id for CPUS, if the bsp apicid is changed to 0x10, the
> jiffies is not changing, So I have to leave to set BSP using apic id 0 in
> LinuxBIOS. And lifting others to use 0x11.....

You should not need that.

> According to Andi, that would be one bug in kernel .....

No, after some consideration it's not a bug.

-Andi
