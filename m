Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRBUEu1>; Tue, 20 Feb 2001 23:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbRBUEuS>; Tue, 20 Feb 2001 23:50:18 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:2567 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129249AbRBUEuO>; Tue, 20 Feb 2001 23:50:14 -0500
Date: Tue, 20 Feb 2001 22:48:30 -0600
To: Peter Bergner <bergner@borg.umn.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, bergner@us.ibm.com
Subject: Re: Different CFLAGS for arch and non-arch files.
Message-ID: <20010220224830.B28652@cadcamlab.org>
In-Reply-To: <20010220210802.A451159@brule.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010220210802.A451159@brule.borg>; from bergner@borg.umn.edu on Tue, Feb 20, 2001 at 09:08:02PM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Peter Bergner]
> Hopefully someone can point me in the right direction here.
> I need to use different CFLAGS options depending on whether
> I'm compiling arch dependent code or arch independent code.

Use the per-directory $(EXTRA_CFLAGS), and/or the per-file
$(CFLAGS_foo.o).  See also $(EXTRA_AFLAGS), $(EXTRA_LDFLAGS) and
$(AFLAGS_foo.o).  I suppose there ought to be a $(LDFLAGS_foo.o) for
completeness, but nobody has needed it yet.

Peter
