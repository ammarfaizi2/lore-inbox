Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSLLOIl>; Thu, 12 Dec 2002 09:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264814AbSLLOIk>; Thu, 12 Dec 2002 09:08:40 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:46349 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264838AbSLLOIQ>; Thu, 12 Dec 2002 09:08:16 -0500
Date: Thu, 12 Dec 2002 14:15:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Art Haas <ahaas@airmail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C99 initializers for drivers/scsi (1 of 4)
Message-ID: <20021212141549.A29212@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Art Haas <ahaas@airmail.net>, linux-kernel@vger.kernel.org
References: <20021212140441.GB1794@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021212140441.GB1794@debian>; from ahaas@airmail.net on Thu, Dec 12, 2002 at 08:04:41AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 08:04:41AM -0600, Art Haas wrote:
> Hi.
> 
> Here's a set of patches for converting drivers/scsi to use C99
> initializers. The patches are against 2.5.51.

That's pointless.  If you move them to C99 initializers also get rid of the
silly template defines at the same time.  There is no urge for the new
syntax, so do it properly if you touch the code.

And btw, scsi patches go to linux-scsi..

