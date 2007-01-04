Return-Path: <linux-kernel-owner+w=401wt.eu-S932180AbXADR4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbXADR4T (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbXADR4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:56:19 -0500
Received: from mis011.exch011.intermedia.net ([64.78.21.10]:27494 "EHLO
	mis011.exch011.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932182AbXADR4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:56:18 -0500
X-Greylist: delayed 852 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 12:56:18 EST
Message-ID: <459D3C65.2090703@qumranet.com>
Date: Thu, 04 Jan 2007 19:41:57 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/33] KVM: MMU: Cache shadow page tables
References: <459D21DD.5090506@qumranet.com> <20070104092226.91fa2dfe.akpm@osdl.org>
In-Reply-To: <20070104092226.91fa2dfe.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2007 17:42:05.0811 (UTC) FILETIME=[A6785430:01C73027]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Is this intended for 2.6.20, or would you prefer that we release what we
> have now and hold this off for 2.6.21?
>   

Even though these patches are potentially destabilazing, I'd like them 
(and a few other patches) to go into 2.6.20:

- kvm did not exist in 2.6.19, hence we cannot regress from that
- this patchset is the difference between a working proof of concept and 
a generally usable system
- from my testing, it's quite stable

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

