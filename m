Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268580AbUJPDNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268580AbUJPDNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 23:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268588AbUJPDNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 23:13:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268580AbUJPDNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 23:13:06 -0400
Date: Sat, 16 Oct 2004 04:13:01 +0100
From: Joel Becker <jlbec@evilplan.org>
To: Yasushi Saito <ysaito@hpl.hp.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       Janet Morgan <janetmor@us.ibm.com>
Subject: Re: [PATCH 1/2]  aio: add vectored I/O support
Message-ID: <20041016031301.GC17142@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Yasushi Saito <ysaito@hpl.hp.com>, linux-aio@kvack.org,
	linux-kernel@vger.kernel.org, suparna@in.ibm.com,
	Janet Morgan <janetmor@us.ibm.com>
References: <416EDD19.3010200@hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416EDD19.3010200@hpl.hp.com>
User-Agent: Mutt/1.4.1i
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 01:10:01PM -0700, Yasushi Saito wrote:
> This is a patch against 2.6.9-rc3-mm3 that add supports for vectored 
> async I/O.  It adds two additional commands, IO_CMD_PREADV and 
> IO_CMD_PWRITEV to libaio.h. The below is roughly what I did:

	How does this differ substantially from lio_listio() of each I/O
range?  Does it have some significant performance win, or is it just
aiming for a completeness that POSIX doesn't (to my knowledge) specify?

Joel

-- 

Life's Little Instruction Book #464

	"Don't miss the magic of the moment by focusing on what's
	 to come."

			http://www.jlbec.org/
			jlbec@evilplan.org
