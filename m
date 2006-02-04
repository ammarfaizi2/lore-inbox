Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946302AbWBDE2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946302AbWBDE2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 23:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946303AbWBDE2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 23:28:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946302AbWBDE2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 23:28:13 -0500
Date: Fri, 3 Feb 2006 20:27:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: pj@sgi.com, maule@sgi.com, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com, gregkh@suse.de
Subject: Re: Altix SN2 2.6.16-rc1-mm5 build breakage (was:  msi support)
Message-Id: <20060203202742.1e514fcc.akpm@osdl.org>
In-Reply-To: <20060203202531.27d685fa.akpm@osdl.org>
References: <20060119194647.12213.44658.14543@lnx-maule.americas.sgi.com>
	<20060119194702.12213.16524.93275@lnx-maule.americas.sgi.com>
	<20060203201441.194be500.pj@sgi.com>
	<20060203202531.27d685fa.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> So it
>  looks like you've found a fix for a patch which isn't actually in -mm any
>  more.  I sent that fix to Greg the other day.

Actually, gregkh-pci-altix-msi-support-git-ia64-fix.patch fix`es
git-ia64.patch when gregkh-pci-altix-msi-support.patch is also applied, so
it's not presently useful to either Greg or Tony.  I'll take care of it,
somehow..

