Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbVCDQ4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbVCDQ4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 11:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbVCDQ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:56:16 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:4550 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262918AbVCDQqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:46:33 -0500
Date: Fri, 4 Mar 2005 10:46:25 -0600
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050304164625.GU1220@austin.ibm.com>
References: <422428EC.3090905@jp.fujitsu.com> <20050301144211.GI28741@parcelfarce.linux.theplanet.co.uk> <20050301192711.GE1220@austin.ibm.com> <42255971.4070608@jp.fujitsu.com> <20050302192043.GJ1220@austin.ibm.com> <4227C1F1.6040508@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4227C1F1.6040508@jp.fujitsu.com>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 11:03:29AM +0900, Hidetoshi Seto was heard to remark:
> >p.s. I would like to have iochk_read() take struct pci_dev * as an
> >argument.  (I could store a pointer to pci_dev in the "cookie" but
> >that seems odd).
> 
> I'd like to store the pointer and handle all only with the cookie...

OK then.

> Or is it needed to pass different device to iochk_clear() and iochk_read()?

No.

--linas
