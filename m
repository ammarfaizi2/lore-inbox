Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUAPOGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbUAPOGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:06:24 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:17924 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265525AbUAPOGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:06:21 -0500
Date: Fri, 16 Jan 2004 14:06:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040116140615.A24102@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lars Marowsky-Bree <lmb@suse.de>,
	Matt Domsch <Matt_Domsch@dell.com>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org
References: <40033D02.8000207@adaptec.com> <16389.52150.148792.875315@notabene.cse.unsw.edu.au> <20040115155221.A31378@lists.us.dell.com> <20040116092447.GF22417@marowsky-bree.de> <20040116074336.A12893@lists.us.dell.com> <20040116135646.GD27825@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040116135646.GD27825@marowsky-bree.de>; from lmb@suse.de on Fri, Jan 16, 2004 at 02:56:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 02:56:46PM +0100, Lars Marowsky-Bree wrote:
> If it encodes the bus/id/lun, I can forsee bad effects if the device
> enumeration changes because the HBAs get swapped in their slots ;-)

A bus/id/lun enumeration is completely bogus.  Think (S)ATA, FC or
iSCSI.

So is there a pointer to the current version of the spec?  Just reading
these multi-path enumerations start to give me the feeling this spec
is designed rather badly..

