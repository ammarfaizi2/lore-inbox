Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUBXUoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUBXUn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:43:56 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:53002 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262454AbUBXUng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:43:36 -0500
Date: Tue, 24 Feb 2004 20:43:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH][BUGFIX] : megaraid patch for 2.10.1 (irq disable bug fix)
Message-ID: <20040224204327.A27822@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Mukker, Atul" <Atulm@lsil.com>,
	'James Bottomley' <James.Bottomley@SteelEye.com>,
	'Arjan van de Ven' <arjanv@redhat.com>,
	'Paul Wagland' <paul@wagland.net>,
	Matthew Wilcox <willy@debian.org>,
	"Bagalkote, Sreenivas" <sreenib@lsil.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3DA@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC3DA@exa-atlanta.se.lsil.com>; from Atulm@lsil.com on Tue, Feb 24, 2004 at 11:04:21AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 11:04:21AM -0500, Mukker, Atul wrote:
> The driver package is available in usual location, too big to be inlined :-)
> ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-unified-2.20.0.0.02.24
> .2004-alpha1/

James already mentioned the probing issue and looking further through the
driver there's lots of need for improvement.  I think we should try to get
2.6 merged up with all the changes from the last unified driver and additional
fixes posted to the list (e.g. the dma_sync thing, did you have a chance to
look at it?) so that we have a proben base until we look into it.

P.S. from  a sort look the fusion-based adapters seem to be completely
different from existing megaraid adapters.  What non-trivial code is
actually shared?

