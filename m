Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbUBYVmL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUBYVla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:41:30 -0500
Received: from lists.us.dell.com ([143.166.224.162]:44005 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261604AbUBYVjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:39:00 -0500
Date: Wed, 25 Feb 2004 15:38:21 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: "'Christoph Hellwig'" <hch@infradead.org>, "Mukker, Atul" <Atulm@lsil.com>,
       "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-al pha1
Message-ID: <20040225153821.C14838@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3E7@exa-atlanta.se.lsil.com> <20040225204441.A9291@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040225204441.A9291@infradead.org>; from hch@infradead.org on Wed, Feb 25, 2004 at 08:44:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 08:44:41PM +0000, 'Christoph Hellwig' wrote:
> On Wed, Feb 25, 2004 at 03:38:48PM -0500, Mukker, Atul wrote:
> > > of their own, e.g. mptraid
> > Although, this simplifies the development and maintenance effort, having a
> > single driver to drive both controllers or two independent drivers is not
> > always our decision. Most often, it would be Dell's preference. 
> 
> Well, I think the people at Dell should get down from their fucking crackpipe
> then.  (Matt, did you hear that?  please stop this kind of marketing driven
> junk, thanks)

Yes, I'll try to figure out where this request came from, if from
anyone at Dell.  My guess is it's related to other operating systems,
over which I have no control, but isn't relevant to Linux.

In general, I tend to fight exactly the opposite - people wanting
drivers split out for "new technology" - say, PCI Express, when the
driver<->firmware API hasn't changed, which is just wrong again.

If it's got a different driver<->firmware API, then it needs a new
driver.  If it's the same API, then it should be the same driver.

FWIW, I'm out of the office for the next couple weeks with a new baby,
thus limited sleep and access to people, but I'll discover what I
can, and will take the heat internally for saying "split the driver"
if in fact you've got two different APIs, as I suspect you do.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
