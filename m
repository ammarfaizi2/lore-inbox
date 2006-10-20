Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946191AbWJTNSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946191AbWJTNSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946197AbWJTNSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:18:33 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:31723 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1946191AbWJTNSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:18:32 -0400
Date: Fri, 20 Oct 2006 15:18:28 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jon Mason <jdmason@gmail.com>
Subject: Re: [PATCH] [x86-64] Calgary: increase PHB1 split transaction timeout
Message-ID: <20061020131828.GA5211@rhun.haifa.ibm.com>
References: <39faf4c673f99e4ee2ed.1161250303@rhun.haifa.ibm.com> <200610201453.25131.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610201453.25131.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 02:53:25PM +0200, Andi Kleen wrote:
> On Thursday 19 October 2006 11:35, Muli Ben-Yehuda wrote:
> > This patch increases the timeout for PCI split transactions on PHB1 on
> > the first Calgary to work around an issue with the aic94xx
> > adapter. Fixes kernel.org bugzilla #7180
> > (http://bugzilla.kernel.org/show_bug.cgi?id=7180)
> 
> Needed for .19 i guess?

That would be best, since it's a very low risk bug fix. It's not
critical though - it only hit one machine that we know of.

Thanks,
Muli
