Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbULCSiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbULCSiP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 13:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbULCSiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 13:38:15 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:22216 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262554AbULCSh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 13:37:56 -0500
Date: Fri, 3 Dec 2004 19:37:34 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Francois Romieu <romieu@fr.zoreil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 - e1000 - page allocation failed
Message-ID: <20041203183734.GA29437@mail.muni.cz>
References: <20041021221622.GA11607@mail.muni.cz> <20041021225825.GA10844@electric-eye.fr.zoreil.com> <20041022025158.7737182c.akpm@osdl.org> <20041022120821.GA12619@mail.muni.cz> <417900D6.4030902@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <417900D6.4030902@yahoo.com.au>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 10:45:10PM +1000, Nick Piggin wrote:
> >>a back-to-back GFP_ATOMIC allocation of 256 skbs could easily exhaust the
> >>page allocator pools.
> >>
> >>Probably this machine needs to increase /proc/sys/vm/min_free_kbytes.
> >
> >
> >It did not help.
> >
> 
> What did you increase it to? What was the allocation failure message?

Sorry for late answer I missed this mail. I increased it to 10MB and failuer
message was the same...

-- 
Luká¹ Hejtmánek
