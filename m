Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWHaN1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWHaN1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWHaN1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:27:31 -0400
Received: from cs.columbia.edu ([128.59.16.20]:19133 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S932280AbWHaN13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:27:29 -0400
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable
	the	block	layer [try #2]
From: Shaya Potter <spotter@cs.columbia.edu>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Matthew Wilcox <matthew@wil.cx>, John Stoffel <john@stoffel.org>,
       Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
In-Reply-To: <44F6E12B.1090700@s5r6.in-berlin.de>
References: <20060829115138.GA32714@infradead.org>
	 <20060825142753.GK10659@infradead.org>
	 <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
	 <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>
	 <10117.1156522985@warthog.cambridge.redhat.com>
	 <15945.1156854198@warthog.cambridge.redhat.com>
	 <20060829122501.GA7814@infradead.org> <20060829195845.GA13357@kroah.com>
	 <17652.44254.620358.974993@stoffel.org>
	 <20060831030134.GA4919@parisc-linux.org>
	 <1156993496.4381.3.camel@localhost.localdomain>
	 <44F6A385.9090508@s5r6.in-berlin.de>
	 <1157027520.4381.10.camel@localhost.localdomain>
	 <44F6E12B.1090700@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 09:27:08 -0400
Message-Id: <1157030829.4381.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter2.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 15:16 +0200, Stefan Richter wrote:
> Shaya Potter wrote:
> > when I said "driver" I meant more along the line of SCSI hardware
> > instead of things that use the "Linux" scsi subsystem.
> [...]
> > So you have a "virtual" SCSI_SUBSYSTEM which usb-storage, sbp2, sata all
> > pull in by selecting it.
> > 
> > you have SCSI_HARDWARE that adaptec, buslogic, lsilogic...... depend on.
> > SCSI_HARDWARE would also select "SCSI_SUBSYSTEM".
> 
> One nit: SBP-2 is SCSI.

ok, but you should get the point.  

basically anything "selectable" perhaps should be a purely "virtual" (as
in not shown in XYZconfig) option.

how one wants to name the options doesn't really bother me.

