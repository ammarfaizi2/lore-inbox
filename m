Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWFWMdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWFWMdE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWFWMdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:33:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:28355 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932580AbWFWMdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:33:03 -0400
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [Patch] apic: fix apic error on bootup
Date: Fri, 23 Jun 2006 14:30:54 +0200
User-Agent: KMail/1.9.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <20060622180534.A25240@unix-os.sc.intel.com>
In-Reply-To: <20060622180534.A25240@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606231430.54882.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 June 2006 03:05, Siddha, Suresh B wrote:
> Appended patch fixes the "APIC error on CPUX: 00(40)" observed during bootup.
> 
> From SDM Vol-3A "Valid Interrupt Vectors" section:
> 	"When an illegal vector value (0-15) is written to an LVT entry
> 	and the delivery mode is Fixed, the APIC may signal an illegal
> 	vector error, with out regard to whether the mask bit is set
> 	or whether an interrupt is actually seen on input."

Merged thanks

-Andi
