Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbULHNPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbULHNPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbULHNPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:15:22 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:8358 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261206AbULHNPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:15:19 -0500
Date: Wed, 8 Dec 2004 14:14:42 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>,
       Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041208131442.GF13592@mail.muni.cz>
References: <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org> <20041202231837.GB15185@mail.muni.cz> <20041202161839.736352c2.akpm@osdl.org> <20041203121129.GC27716@mail.muni.cz> <41B6343A.9060601@cyberone.com.au> <20041207225932.GB12030@mail.muni.cz> <41B63738.2010305@cyberone.com.au> <20041208111832.GA13592@mail.muni.cz> <41B6E415.4000602@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41B6E415.4000602@cyberone.com.au>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 10:23:01PM +1100, Nick Piggin wrote:
> >No better. min_free_kb is set by default to 3831 but I can still reproduce 
> >this:
> >
> >swapper: page allocation failure. order:0, mode:0x20
> >
> 
> What value do you have to raise min_free_kb to in order to be unable to
> reproduce the warnings?

32MB seems to be ok but it will require further testing to be sure.

-- 
Luká¹ Hejtmánek
