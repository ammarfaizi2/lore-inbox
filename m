Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVBOMIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVBOMIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 07:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVBOMIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 07:08:06 -0500
Received: from colin2.muc.de ([193.149.48.15]:27401 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261695AbVBOMIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 07:08:01 -0500
Date: 15 Feb 2005 13:08:00 +0100
Date: Tue, 15 Feb 2005 13:08:00 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 kernel support MAX memory.
Message-ID: <20050215120800.GA25815@muc.de>
References: <3174569B9743D511922F00A0C943142308085800@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142308085800@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 07:32:42PM -0800, YhLu wrote:
> Andi,
> 
> How much is max RAM 2.6.11 x86_64 support on AMD64?
> 64G or 128G?

46bits in theory (64TB), however current CPUs only support
upto 40bits (AMD) or 36bits (Intel).  There is some other
code that is also limited to 40bits right now like AGP
or IOMMU or MTRR, that is all due to hardware limitations.

-Andi
