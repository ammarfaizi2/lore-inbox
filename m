Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVJCT34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVJCT34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVJCT34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:29:56 -0400
Received: from amdext3.amd.com ([139.95.251.6]:7918 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S932376AbVJCT3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:29:55 -0400
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Mon, 3 Oct 2005 13:46:55 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Adrian Bunk" <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Geode GX/LX support
Message-ID: <20051003194655.GA30975@cosmic.amd.com>
References: <20051003174738.GC29264@cosmic.amd.com>
 <20051003180532.GE3652@stusta.de>
MIME-Version: 1.0
In-Reply-To: <20051003180532.GE3652@stusta.de>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5F59262OC714129-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +config MGEODE_GX
> > +	bool "Geode GX"
> > +	help
> > +	  Select this for AMD Geode GX processors.  Enables use of some extended
> > +	  instructions, and passes appropriate optimization flags to GCC.
> >...
> 
> The "and passes appropriate optimization flags to GCC" part seems to be 
> missing in your patches.

Yes - that is incorrect.  As you can no doubt see, I cut-n-pasted from
another processor.

> And it's not clear to me how your new MGEODE_GX option relates to the 
> already existing MGEODEGX1 option.

The already existing GEODEGX1 option as it stands has an invalid cache line
size, it should be 4 not 5.  I'll fix that up with the next revision of the 
patch.

Thanks for your comments,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

