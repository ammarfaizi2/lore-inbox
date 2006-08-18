Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWHRIaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWHRIaB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWHRIaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:30:01 -0400
Received: from colin.muc.de ([193.149.48.1]:40973 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751163AbWHRIaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:30:00 -0400
Date: 18 Aug 2006 10:29:58 +0200
Date: Fri, 18 Aug 2006 10:29:58 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/3] Support piping into commands in /proc/sys/kernel/core_pattern
Message-ID: <20060818082958.GA5862@muc.de>
References: <20060814127.183332000@suse.de> <20060814112732.684D313BD9@wotan.suse.de> <20060816084354.GF24139@kroah.com> <20060816111801.0fc5093e.ak@muc.de> <20060816111025.1ab702a1.akpm@osdl.org> <20060817094640.GA3173@muc.de> <1155814064.15195.60.camel@localhost.localdomain> <20060817223009.932f9383.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817223009.932f9383.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But still.   Is this code secure?

Any auditing from third parties appreciated.

I don't know of any obvious flaws (at least assuming the pipe handler
isn't insecure code), but then I'm biased. 

-Andi
