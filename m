Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVKDQgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVKDQgC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVKDQgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:36:01 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:51650 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932157AbVKDQgB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:36:01 -0500
Date: Fri, 4 Nov 2005 10:35:57 -0600
To: John Rose <johnrose@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
       External List <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/42]: ppc64: bugfix: crash on PHB add
Message-ID: <20051104163557.GR19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005117.GA26991@mail.gnucash.org> <1131121255.9574.11.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131121255.9574.11.camel@sinatra.austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 10:20:55AM -0600, John Rose was heard to remark:
> > This patch fixes a bug related to dlpar PHB add, after a PHB removal.
> 
> This and patch 18 seem logically separate from the feature.  This
> complicates review and adds to an already large patch set.  Could we
> handle these separately?

I sent these in separetely, a month ago, as bug fixes for the dlpar 
crashes in the pre-2.6.14 kernels, but these were never applied.  
Since they're needed to get EEH to work, I just sent them in again 
with this set.  Yes, I'm aware that the patch you sent yesterday
fixes the same bug in almost the same way. 

What you really want to concentrate on are patches 20 through 23
which mess with the guts of the rpaphp code. But again, these are 
the same old patches, they have not changed since the submit last 
month.

--linas

