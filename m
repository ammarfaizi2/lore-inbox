Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271751AbTGRMcA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271750AbTGRMb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:31:59 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:16656 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271749AbTGRMbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:31:55 -0400
Date: Fri, 18 Jul 2003 13:46:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b4).
Message-ID: <20030718134650.A28908@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lars Marowsky-Bree <lmb@suse.de>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B0598B10@AVEXCH02.qlogic.org> <20030718122304.A23013@infradead.org> <20030718121202.GC6520@marowsky-bree.de> <20030718131352.A26546@infradead.org> <20030718122622.GD6520@marowsky-bree.de> <20030718133404.A26784@infradead.org> <20030718124127.GF6520@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030718124127.GF6520@marowsky-bree.de>; from lmb@suse.de on Fri, Jul 18, 2003 at 02:41:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 02:41:27PM +0200, Lars Marowsky-Bree wrote:
> However, while I agree about this being cruft in qla2xxx, it is _used_.

And?  LiS is used, too as are tons of hacks that have no chance of
getting in mainline ever.

> It's a driver / HBA feature which is actively deployed. I'd like to see
> it go sooner than later, but by blocking this feature you preclude
> those users of the driver from using the mainline one again, which is
> the entire point of this exercise.
> 
> Dropping such a feature needs some preparation to protect the users, and
> isn't justified by the personal dislikes of myself or you I'm afraid
> ;-)

It's not about personal dislikes but about policies.  If we allow qlogic
to get their mpio code into the kernel there'll soon be more and more
HBA vendors who do the same.

And it's not like the code will vanish from earth if it's gone from
the mainline driver, if SuSE wishes to patch it back in to protect
the investments of their custorers (or insert random other CEO-speak
here) they're free to patch in the mess again.

