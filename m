Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030684AbWAJX3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030684AbWAJX3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030688AbWAJX3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:29:21 -0500
Received: from fmr23.intel.com ([143.183.121.15]:18375 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030684AbWAJX3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:29:20 -0500
Date: Tue, 10 Jan 2006 15:29:05 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keith Owens <kaos@sgi.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       tony.luck@intel.com, Systemtap <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [patch 1/2] [BUG]kallsyms_lookup_name should return the text addres
Message-ID: <20060110152904.A16312@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060110130737.A14197@unix-os.sc.intel.com> <18641.1136934686@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <18641.1136934686@ocs3.ocs.com.au>; from kaos@sgi.com on Wed, Jan 11, 2006 at 10:11:26AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 10:11:26AM +1100, Keith Owens wrote:
> Keshavamurthy Anil S (on Tue, 10 Jan 2006 13:07:37 -0800) wrote:
> >On Tue, Jan 10, 2006 at 08:45:02PM +0000, Paulo Marques wrote:
> >But my [patch 2/2] speeds up the lookup and that can go in, I think.
> >Please ack that patch if you think so.
> 
> Your second patch changes the behaviour of kallsyms lookup w.r.t
> duplicate symbols.
With this send patch, kallsyms lookup first finds 
the real text address which is what we want. If you consider
this as the change in behaviour, what is the negetive effect of this
I am unable to get it.

In fact on arch which has the same address for 'U' and 't' type,
the search will first find the 't' type and ends the search soon, 
if we have my second patch.


regards,
-Anil

