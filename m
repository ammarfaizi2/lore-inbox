Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUGABdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUGABdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 21:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUGABdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 21:33:06 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:22200 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262906AbUGABdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 21:33:03 -0400
Subject: Re: per-process namespace?
From: Ram Pai <linuxram@us.ibm.com>
To: "Serge E. Hallyn" <hallyn@CS.WM.EDU>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040701001442.GA28099@escher.cs.wm.edu>
References: <1088534826.2816.38.camel@dyn319623-009047021109.beaverton.ibm.com>
	 <40E1DABD.9000202@sun.com>
	 <20040629221025.GI12308@parcelfarce.linux.theplanet.co.uk>
	 <40E2BCE1.3040302@sun.com> <1088619320.2927.77.camel@localhost.localdomain>
	 <20040701001442.GA28099@escher.cs.wm.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1088645561.2927.196.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jun 2004 18:32:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-30 at 17:14, Serge E. Hallyn wrote:
> > The per-process namespace concept comes in handy here except for the
> > static nature of the namespace. In the sense, any changes to the system
> > namespace do not reflect in the children namespace.
> 
> Static?
> 
> It's not static!  It's private, as advertised.

> It sounds like you're asking (or your customer is asking) for
> copy-on-write namespaces  :)
> 
Yes! exactly right. A copy-on-write namespace. That way we dont even
have to invent new interfaces to define maskable mount-points that I 
mentioned  earlier.


