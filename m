Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271106AbTHQUWd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271091AbTHQUWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:22:33 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:30080 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S271106AbTHQUWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:22:32 -0400
Date: Sun, 17 Aug 2003 21:22:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Rychter <jan@rychter.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Requested FAQ addition - Mandrake and partial-i686 platforms
Message-ID: <20030817202229.GB3543@mail.jlokier.co.uk>
References: <3F38FE5B.1030102@yahoo.com> <1060705037.12532.49.camel@dhcp22.swansea.linux.org.uk> <864r0lwmov.fsf@trasno.mitica> <m2r83kce2h.fsf@tnuctip.rychter.com> <1061148472.23525.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061148472.23525.7.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sul, 2003-08-17 at 19:51, Jan Rychter wrote:
> > Does anybody have the actual CPU revisions corresponding to these
> > changes? There has been a lot of confusion over this.
> 
> Ezra -> 3dnow, no cmov  (500MHz->1Ghz)
> Nemeiah -> sse, cmov (1Ghz-)
> Anataur -> dunno yet, I'd assume sse
> 
> The chips report cmov only if they have full cmov instructions, so
> a look at /proc/cpuinfo will tell you.

So the register-only cmov on the Cyrix which you mentioned does not
come with the cpuid cmov flag?

-- Jamie

