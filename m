Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269135AbTGJJdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 05:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269137AbTGJJdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 05:33:05 -0400
Received: from holomorphy.com ([66.224.33.161]:49328 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S269135AbTGJJdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 05:33:02 -0400
Date: Thu, 10 Jul 2003 02:48:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Piet Delaney <piet@www.piet.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm3 - apm_save_cpus() Macro still bombs out
Message-ID: <20030710094841.GU15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Piet Delaney <piet@www.piet.net>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030708223548.791247f5.akpm@osdl.org> <200307101122.59138.schlicht@uni-mannheim.de> <20030710092720.GT15452@holomorphy.com> <200307101142.37137.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307101142.37137.schlicht@uni-mannheim.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 11:27, William Lee Irwin III wrote:
>> Could you try the following?

On Thu, Jul 10, 2003 at 11:42:35AM +0200, Thomas Schlichter wrote:
> OK, I tried it. For me it compiles!
> But the size of the resulting objectfile's text section is about 64bytes 
> larger than with my patch. So it seems that gcc3.3 wasn't able to optimize 
> away all the unneeded stuff...
> And I don't think my patch is that ugly, but hey, it's your decision...

64B? Why do you care?


-- wli
