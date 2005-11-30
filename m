Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVK3NC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVK3NC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 08:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVK3NC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 08:02:28 -0500
Received: from ns1.suse.de ([195.135.220.2]:9453 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751202AbVK3NC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 08:02:27 -0500
Date: Wed, 30 Nov 2005 14:02:16 +0100
From: Andi Kleen <ak@suse.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
Message-ID: <20051130130216.GL19515@wotan.suse.de>
References: <20051130042118.GA19112@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130042118.GA19112@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 11:21:18PM -0500, Benjamin LaHaise wrote:
> Hello Andi,
> 
> The following emails contain the patches to convert x86-64 to store current 
> in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).  This 
> provides a significant amount of code savings (~43KB) over the current 
> use of the per cpu data area.  I also tested using r15, but that generated 
> code that was larger than that generated with r10.  This code seems to be 
> working well for me now (it stands up to 32 and 64 bit processes and ptrace 
> users) and would be a good candidate for further exposure.

Looks good thanks. It will need longer testing though.

-Andi
