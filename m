Return-Path: <linux-kernel-owner+w=401wt.eu-S932171AbXAFUmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbXAFUmD (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbXAFUmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:42:02 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:10423 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932171AbXAFUmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:42:01 -0500
Subject: Re: + paravirt-vmi-timer-patches.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, chrisw@sous-sol.org,
       jeremy@xensource.com, rusty@rustcorp.com.au
In-Reply-To: <45A00878.1000705@vmware.com>
References: <200612152227.kBFMRNuQ002977@shell0.pdx.osdl.net>
	 <1168106760.26086.222.camel@imap.mvista.com>  <45A00878.1000705@vmware.com>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 12:40:57 -0800
Message-Id: <1168116057.26086.227.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-06 at 12:37 -0800, Zachary Amsden wrote:

> >
> > There is already a dynamic tick (NO_HZ) system in the -mm tree .. Given
> > that this implementation seems unnecessary. Why do you need another
> > different system to do this?
> >   
> 
> We don't.  This was written before the dynamic tick code, and now they 
> need to be merged.  Until then, they can safely coexist.

So really this can't go upstream till that merge happens. What's
preventing you from just directly using NO_HZ without changes?

Daniel  

