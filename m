Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbULIJDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbULIJDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 04:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbULIJDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 04:03:13 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:62898 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261497AbULIJDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 04:03:11 -0500
Date: Thu, 9 Dec 2004 10:02:45 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>,
       Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041209090245.GB15537@mail.muni.cz>
References: <20041202231837.GB15185@mail.muni.cz> <20041202161839.736352c2.akpm@osdl.org> <20041203121129.GC27716@mail.muni.cz> <41B6343A.9060601@cyberone.com.au> <20041207225932.GB12030@mail.muni.cz> <41B63738.2010305@cyberone.com.au> <20041208111832.GA13592@mail.muni.cz> <41B6E415.4000602@cyberone.com.au> <20041208131442.GF13592@mail.muni.cz> <41B81254.4040107@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41B81254.4040107@cyberone.com.au>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 07:52:36PM +1100, Nick Piggin wrote:
> >32MB seems to be ok but it will require further testing to be sure.
> >
> >
> 
> Seems pretty excessive - although maybe your increased socket buffers and
> txqueuelen are contributing?

Yes they are. Without increasing it is just ok. But increasing is ok in 2.6.6.

-- 
Luká¹ Hejtmánek
