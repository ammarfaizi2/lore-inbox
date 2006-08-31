Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWHaNUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWHaNUd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWHaNUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:20:33 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:20897 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932222AbWHaNUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:20:32 -0400
Message-ID: <44F6E12B.1090700@s5r6.in-berlin.de>
Date: Thu, 31 Aug 2006 15:16:27 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Shaya Potter <spotter@cs.columbia.edu>
CC: Matthew Wilcox <matthew@wil.cx>, John Stoffel <john@stoffel.org>,
       Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the	block	layer
 [try #2]
References: <20060829115138.GA32714@infradead.org>	 <20060825142753.GK10659@infradead.org>	 <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>	 <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>	 <10117.1156522985@warthog.cambridge.redhat.com>	 <15945.1156854198@warthog.cambridge.redhat.com>	 <20060829122501.GA7814@infradead.org> <20060829195845.GA13357@kroah.com>	 <17652.44254.620358.974993@stoffel.org>	 <20060831030134.GA4919@parisc-linux.org>	 <1156993496.4381.3.camel@localhost.localdomain>	 <44F6A385.9090508@s5r6.in-berlin.de> <1157027520.4381.10.camel@localhost.localdomain>
In-Reply-To: <1157027520.4381.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter wrote:
> when I said "driver" I meant more along the line of SCSI hardware
> instead of things that use the "Linux" scsi subsystem.
[...]
> So you have a "virtual" SCSI_SUBSYSTEM which usb-storage, sbp2, sata all
> pull in by selecting it.
> 
> you have SCSI_HARDWARE that adaptec, buslogic, lsilogic...... depend on.
> SCSI_HARDWARE would also select "SCSI_SUBSYSTEM".

One nit: SBP-2 is SCSI.
-- 
Stefan Richter
-=====-=-==- =--- =====
http://arcgraph.de/sr/
