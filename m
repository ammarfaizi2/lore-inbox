Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVCSCrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVCSCrv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 21:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVCSCru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 21:47:50 -0500
Received: from fmr23.intel.com ([143.183.121.15]:18363 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261692AbVCSCrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 21:47:31 -0500
Subject: Re: [BKPATCH] ACPI for 2.6.12-rc1
From: Len Brown <len.brown@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: romano@dea.icai.upco.es, romanol@upco.es, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20050318152122.7994965b.akpm@osdl.org>
References: <1111127024.9332.157.camel@d845pe>
	 <20050318150129.GB22887@pern.dea.icai.upco.es>
	 <20050318152122.7994965b.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1111200429.5935.13.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Mar 2005 21:47:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 18:21, Andrew Morton wrote:
> Romano Giannetti <romanol@upco.es> wrote:
> >
> > Could I humble advocating pushing the patch
> >  http://bugme.osdl.org/attachment.cgi?id=4516&action=view ,please?
> It fixed a
> >  very bad regression in hotkey event from 2.6.9...
> 
> It seems to not be in ACPI bk yet.  What bug number is that actually
> attached to?  There seems to be no way to go backwards from the URL.


Yes, this is an important fix, and I'll be pushing
it up to-akpm tonight along with a bucket-full of
other important fixes.  The push to Linus yesterday
was to clear the pipeline for this next batch, which
should hopefully also make 2.6.12.

cheers,
-Len

ps. You can query bugzilla for comments containing string "id=4516"
and you find this is Luming's burst-mode EC patch:
http://bugzilla.kernel.org/show_bug.cgi?id=3851


