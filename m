Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbUCSW0a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUCSW0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:26:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44763 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263127AbUCSW00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:26:26 -0500
Date: Fri, 19 Mar 2004 22:26:24 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Matthew Wilcox'" <willy@debian.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'matt_domsch@dell.com'" <matt_domsch@dell.com>,
       "'Paul Wagland'" <paul@wagland.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-al pha1
Message-ID: <20040319222624.GT25059@parcelfarce.linux.theplanet.co.uk>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC49E@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC49E@exa-atlanta.se.lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 05:17:35PM -0500, Mukker, Atul wrote:
> 
> > that you don't do things like
> > 
> > #if defined(__x86_64__) || defined(__ia64__)
> > #endif
> > 
> > when you really mean
> > 
> > #ifdef CONFIG_COMPAT
> > #endif
> What does CONFIG_COMPAT do anyway? We could not find much information about
> it's usage

CONFIG_COMPAT is defined by the 64-bit architectures when they want to
be able to run 32-bit binaries.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
