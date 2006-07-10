Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422802AbWGJU17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422802AbWGJU17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWGJU16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:27:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:63440 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422802AbWGJU16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:27:58 -0400
Message-ID: <44B2B84A.2020006@fr.ibm.com>
Date: Mon, 10 Jul 2006 22:27:54 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1 oops on x86_64
References: <20060709021106.9310d4d1.akpm@osdl.org> <44B12C74.9090104@fr.ibm.com> <20060709132135.6c786cfb.akpm@osdl.org> <Pine.LNX.4.64.0607100856540.4491@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0607101036060.5059@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607101036060.5059@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Mon, 10 Jul 2006, Christoph Lameter wrote:
> 
>> Hmm... Actually we could leave __GFP_HIGHMEM at it prior value since
>> GFP_ZONEMASK masks it out anyways. Need to test this though. This may
>> also make some of the __GFP_DMA32 ifdefs unnecessary.
> 
> Here is the patch that fixes __GFP_DMA32 and __GFP_HIGHMEM to always
> be nonzero. However, after the #ifdef in my last patch there is no
> remaining instance of this left. The cure here adds some complexity:

My 2.6.18-rc1-mm1 is now much more friendly with the last 2 patches.

Thanks !

C.

