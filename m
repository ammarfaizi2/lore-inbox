Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWKBRkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWKBRkU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWKBRkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:40:20 -0500
Received: from colin.muc.de ([193.149.48.1]:47367 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751049AbWKBRkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:40:19 -0500
Date: 2 Nov 2006 18:40:16 +0100
Date: Thu, 2 Nov 2006 18:40:16 +0100
From: Andi Kleen <ak@muc.de>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Vivek Goyal <vgoyal@in.ibm.com>, magnus.damm@gmail.com,
       fastboot@lists.osdl.org
Subject: Re: [PATCH] x86_64: setup saved_max_pfn correctly (kdump)
Message-ID: <20061102174016.GA52800@muc.de>
References: <20061102131934.24684.93195.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102131934.24684.93195.sendpatchset@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 10:19:34PM +0900, Magnus Damm wrote:
> x86_64: setup saved_max_pfn correctly
> 
> 2.6.19-rc4 has broken CONFIG_CRASH_DUMP support on x86_64. It is impossible 
> to read out the kernel contents from /proc/vmcore because saved_max_pfn is set
> to zero instead of the max_pfn value before the user map is setup.

Do you know what patch has broken it? 

Or did just nobody test crash dump at all since -rc* started?

-Andi
