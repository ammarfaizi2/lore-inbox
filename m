Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316960AbSE1VJf>; Tue, 28 May 2002 17:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSE1VJe>; Tue, 28 May 2002 17:09:34 -0400
Received: from holomorphy.com ([66.224.33.161]:41870 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316960AbSE1VJe>;
	Tue, 28 May 2002 17:09:34 -0400
Date: Tue, 28 May 2002 14:09:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020528210917.GU14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz> <20020527194018.GQ14918@holomorphy.com> <20020528193220.GB189@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 09:32:22PM +0200, Pavel Machek wrote:
> Hi!
> I had to add
> 	if (!curr) break; 
> to fix the oops. It now looks way nicer. Thanx.

It's pretty odd that this happens to the buddy lists. I guess if it's
needed as a stopgap measure, I can't complain too much, but I'd suspect
something's corrupting it or you're catching a buddy list operation in
progress. I might be interested in taking a stab at finding out where
the corruption happens if you also think that's what's going on.


Cheers,
Bill
