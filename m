Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWHaDBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWHaDBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 23:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWHaDBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 23:01:37 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:41399 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750722AbWHaDBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 23:01:36 -0400
Date: Wed, 30 Aug 2006 21:01:34 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: John Stoffel <john@stoffel.org>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060831030134.GA4919@parisc-linux.org>
References: <20060829115138.GA32714@infradead.org> <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com> <20060829122501.GA7814@infradead.org> <20060829195845.GA13357@kroah.com> <17652.44254.620358.974993@stoffel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17652.44254.620358.974993@stoffel.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 05:08:46PM -0400, John Stoffel wrote:
> Maybe the better solution is to remove SCSI as an option, and to just
> offer SCSI drivers and USB-STORAGE and other SCSI core using drivers
> instead.  Then the SCSI core gets pulled in automatically.  It's not
> like people care about the SCSI core, just the drivers which depend on
> it.

People don't want to have to say "no" to umpteen scsi drivers.  They
just want to say "no" to SCSI, because they know they don't have scsi.
