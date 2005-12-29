Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVL2MQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVL2MQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 07:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVL2MQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 07:16:22 -0500
Received: from colin.muc.de ([193.149.48.1]:9485 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750717AbVL2MQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 07:16:20 -0500
Date: 29 Dec 2005 13:16:13 +0100
Date: Thu, 29 Dec 2005 13:16:13 +0100
From: Andi Kleen <ak@muc.de>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 write apic id fix
Message-ID: <20051229121613.GB64763@muc.de>
References: <20051229082709.GB1626@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229082709.GB1626@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 01:57:09PM +0530, Vivek Goyal wrote:
> 
> o Apic id is in most significant 8 bits of APIC_ID register. Current code
>   is trying to write apic id to least significant 8 bits. This patch fixes
>   it.
> 
> o This fix enables booting uni kdump capture kernel on a cpu with non-zero
>   apic id.

Thanks merged.
-Andi
