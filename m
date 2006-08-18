Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWHRWUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWHRWUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWHRWUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:20:21 -0400
Received: from xenotime.net ([66.160.160.81]:5002 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751514AbWHRWUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:20:21 -0400
Date: Fri, 18 Aug 2006 15:23:20 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed!
Message-Id: <20060818152320.9f0e3693.rdunlap@xenotime.net>
In-Reply-To: <44E58FDC.6030007@aitel.hist.no>
References: <20060813012454.f1d52189.akpm@osdl.org>
	<200608181134.02427.ak@suse.de>
	<44E588AB.3050900@aitel.hist.no>
	<200608181255.46999.ak@suse.de>
	<44E58FDC.6030007@aitel.hist.no>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 12:01:00 +0200 Helge Hafting wrote:

> Andi Kleen wrote:
> >> I have narrowed it down.  2.6.18-rc4 does not have the 3x time
> >> problem,  while mm1 have it.  mm1 without the hotfix jiffies
> >> patch is just as bad.
> >>     
> >
> > Can you narrow it down to a specific patch in -mm? 
> >   
> How do I do that?  Is -mm available through git somehow,
> or is there some other clever way?

http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

---
~Randy
