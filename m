Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUCWNak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 08:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbUCWNak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 08:30:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14989 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261774AbUCWNai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 08:30:38 -0500
Date: Tue, 23 Mar 2004 13:30:35 +0000
From: Matthew Wilcox <willy@debian.org>
To: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@debian.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH][RELEASE] megaraid 2.10.2 Driver
Message-ID: <20040323133035.GU25059@parcelfarce.linux.theplanet.co.uk>
References: <0E3FA95632D6D047BA649F95DAB60E570230C77B@exa-atlanta.se.lsil.com> <20040323004543.GP25059@parcelfarce.linux.theplanet.co.uk> <20040323062708.A29405@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323062708.A29405@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 06:27:08AM +0000, Christoph Hellwig wrote:
> On Tue, Mar 23, 2004 at 12:45:43AM +0000, Matthew Wilcox wrote:
> > I don't think you understand how CONFIG_COMPAT works.  x86-64 defines it
> > when it wants it:
> 
> But not in 2.4, and this is a 2.4-only patch..

It is?  I didn't see that mentioned anywhere.

Anyway, it's wrong to define LSI_CONFIG_COMPAT based solely on __x86_64__.
You'd also need to check IA32_EMULATION.  Really, it would be simpler
to add CONFIG_COMPAT to 2.4.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
