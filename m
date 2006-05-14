Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWENRLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWENRLJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 13:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWENRLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 13:11:09 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:16818 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751137AbWENRLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 13:11:07 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 23/35] Increase x86 interrupt vector range
Date: Sun, 14 May 2006 19:08:02 +0200
User-Agent: KMail/1.9.1
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Ian Pratt <Ian.Pratt@xensource.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       virtualization <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@sous-sol.org>
References: <200605131346_MC3-1-BFAF-FA0A@compuserve.com> <96b6a9b036fc030017549f3446a13aab@cl.cam.ac.uk>
In-Reply-To: <96b6a9b036fc030017549f3446a13aab@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605141908.04163.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 14. May 2006 09:52, Keir Fraser wrote:
> If we really want it disambiguated then we should call it something 
> like 'bitwise-negated' or 'ones-complemented'. 'Complemented' alone is 
> worse than 'negated' imo, since negation is at least the usual name for 
> the tilde operator in C while complementation is an ambiguous term 
> unless you know the base/radix.

Not really. 

I've seen "negate" only be used to mean "twos complement"
and "invert" only be seen with "ones complement".

So if you like to be clear, just use "negate" vs. "invert".


Regards

Ingo Oeser
