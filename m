Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbUAPOLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265546AbUAPOLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:11:40 -0500
Received: from smtp4.us.dell.com ([143.166.148.135]:39903 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP id S265539AbUAPOLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:11:34 -0500
Date: Fri, 16 Jan 2004 08:11:07 -0600 (CST)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
To: Christoph Hellwig <hch@infradead.org>
cc: Lars Marowsky-Bree <lmb@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
       Scott Long <scott_long@adaptec.com>, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>
Subject: Re: Proposed enhancements to MD
In-Reply-To: <20040116140615.A24102@infradead.org>
Message-ID: <Pine.LNX.4.44.0401160808180.21098-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jan 2004, Christoph Hellwig wrote:
> On Fri, Jan 16, 2004 at 02:56:46PM +0100, Lars Marowsky-Bree wrote:
> > If it encodes the bus/id/lun, I can forsee bad effects if the device
> > enumeration changes because the HBAs get swapped in their slots ;-)

I believe it's just supposed to be a hint to the firmware that the drive 
has roamed from one physical slot to another.
 
> A bus/id/lun enumeration is completely bogus.  Think (S)ATA, FC or
> iSCSI.
> 
> So is there a pointer to the current version of the spec?  Just reading
> these multi-path enumerations start to give me the feeling this spec
> is designed rather badly..

www.snia.org in the DDF TWG section, but requires you be a member of SNIA 
to see at present.  The DDF chairperson is trying to make the draft 
publicly available, and if/when I see that happen I'll post a link to it 
here.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

