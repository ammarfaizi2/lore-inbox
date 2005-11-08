Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVKHAft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVKHAft (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbVKHAft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:35:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:30605 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964909AbVKHAft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:35:49 -0500
Subject: Re: [PATCH 1/4] Memory Add Fixes for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
In-Reply-To: <20051107214859.GD5821@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com>
	 <20051104231800.GB25545@w-mikek2.ibm.com>
	 <1131149070.29195.41.camel@gaston> <20051107204743.GC5821@w-mikek2.ibm.com>
	 <1131397976.4652.52.camel@gaston>  <20051107214859.GD5821@w-mikek2.ibm.com>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 11:35:00 +1100
Message-Id: <1131410101.4652.75.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 13:48 -0800, Mike Kravetz wrote:
> On Tue, Nov 08, 2005 at 08:12:56AM +1100, Benjamin Herrenschmidt wrote:
> > Yes, the MAX_ORDER should be different indeed. But can Kconfig do that ?
> > That is have the default value be different based on a Kconfig option ?
> > I don't see that ... We may have to do things differently here...
> 
> This seems to be done in other parts of the Kconfig file.  Using those
> as an example, this should keep the MAX_ORDER block size at 16MB.

Ok, I verified it does the right thing with Kconfig, thanks.

Paul, can you add to the merge tree too ?

Ben.


