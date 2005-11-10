Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVKJMhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVKJMhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVKJMhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:37:13 -0500
Received: from gate.in-addr.de ([212.8.193.158]:10179 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1750812AbVKJMhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:37:10 -0500
Date: Thu, 10 Nov 2005 13:36:41 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Jan Beulich <JBeulich@novell.com>, Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/39] NLKD/i386 - core adjustments
Message-ID: <20051110123641.GE12185@marowsky-bree.de>
References: <43721024.76F0.0078.0@novell.com> <4372105B.76F0.0078.0@novell.com> <43721119.76F0.0078.0@novell.com> <43721142.76F0.0078.0@novell.com> <43721184.76F0.0078.0@novell.com> <437211B6.76F0.0078.0@novell.com> <20051109190017.GB4047@stusta.de> <43730D3A.76F0.0078.0@novell.com> <20051110102936.GA5376@stusta.de> <43734277.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43734277.76F0.0078.0@novell.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-11-10T12:52:07, Jan Beulich <JBeulich@novell.com> wrote:

> >If there's a chance of a stack overflow the stack usage has to be 
> >reduced until the chance goes down to 0.
> How does one reduce stack usage in the presence of recursion driven by
> user input (referring to expression evaluation)?

Recursion removal is a pretty standard technique and featured in almost
all introductionary computer science texts. A quick google query finds
http://portal.acm.org/citation.cfm?id=359344

All recursive algorithms can be expressed non-recursively, although it
might not always be as nice. Or you can put an upper limit on the
allowed complexity of queries.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

