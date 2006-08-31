Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWHaKOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWHaKOa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWHaKOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:14:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34767 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750817AbWHaKO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:14:29 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17652.44254.620358.974993@stoffel.org> 
References: <17652.44254.620358.974993@stoffel.org>  <20060829115138.GA32714@infradead.org> <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com> <20060829122501.GA7814@infradead.org> <20060829195845.GA13357@kroah.com> 
To: "John Stoffel" <john@stoffel.org>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 31 Aug 2006 11:13:51 +0100
Message-ID: <10385.1157019231@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel <john@stoffel.org> wrote:

> Maybe the better solution is to remove SCSI as an option, and to just
> offer SCSI drivers and USB-STORAGE and other SCSI core using drivers
> instead.  Then the SCSI core gets pulled in automatically.  It's not
> like people care about the SCSI core, just the drivers which depend on
> it.

How do you modularise it then?

David
