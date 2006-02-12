Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWBLVpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWBLVpc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 16:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWBLVpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 16:45:32 -0500
Received: from kanga.kvack.org ([66.96.29.28]:2538 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751019AbWBLVpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 16:45:31 -0500
Date: Sun, 12 Feb 2006 16:40:46 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove the CONFIG_CC_ALIGN_* options
Message-ID: <20060212214046.GA20477@kvack.org>
References: <20060212174802.GJ30922@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212174802.GJ30922@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 06:48:02PM +0100, Adrian Bunk wrote:
> I don't see any use case for the CONFIG_CC_ALIGN_* options:
> - they are only available if EMBEDDED
> - people using EMBEDDED will most likely also enable 
>   CC_OPTIMIZE_FOR_SIZE
> - the default for -Os is to disable alignment

CONFIG_EMBEDDED should actually be spell CONFIG_ADVANCED.  Not everyone 
testing different alignments is building an embedded system targetted for 
size.  The option is just as useful in doing performance comparisons.  
Besides, is it really a maintenence load?

		-ben
