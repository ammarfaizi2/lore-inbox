Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVKEABA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVKEABA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVKEABA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:01:00 -0500
Received: from fmr24.intel.com ([143.183.121.16]:3203 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751142AbVKEABA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:01:00 -0500
Date: Fri, 4 Nov 2005 16:00:01 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, rjw@sisk.pl, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, mingo@elte.hu, linux@brodo.de,
       venkatesh.pallipadi@intel.com
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
Message-ID: <20051104160000.A16485@unix-os.sc.intel.com>
References: <200510311606.36615.rjw@sisk.pl> <200510312045.32908.rjw@sisk.pl> <20051031124216.A18213@unix-os.sc.intel.com> <200511012007.19762.rjw@sisk.pl> <20051101111417.A31379@unix-os.sc.intel.com> <20051104143035.120fe158.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051104143035.120fe158.akpm@osdl.org>; from akpm@osdl.org on Fri, Nov 04, 2005 at 02:30:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 02:30:35PM -0800, Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
> >
> > 
> > ...
> >
> > seems ugly, but i dont find a better looking cure...
> > 
> 
> Could you take another look, please?   It really is pretty gross.

Agree, frankly i didnt like this either, but the calls there were so
nested that i tried doing multiple ways and it appeared they need
to be broken down so much to do this a little cleanly.

i did put a real ugly comment earlier, but i must have removed it in the next 
respin.

I was hoping to do just make the dirs appear/disapper (so i get the 
behaviour i need) and let people more familier with the code go fix it.


> 
> And the second rule of pretty-gross code is to clearly comment it - draw
> 

pretty-gross.... humbly saying that is :-) i will attempt to look at it 
again.

cpufreq folks... if you have better ideas brewing to make this work
in a pretty-clean way.... many thanks!

Cheers,
ashok
