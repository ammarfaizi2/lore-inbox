Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266575AbUHOLAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266575AbUHOLAc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 07:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUHOLAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 07:00:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18149 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266575AbUHOLAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 07:00:31 -0400
Date: Sun, 15 Aug 2004 12:00:30 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
Message-ID: <20040815110030.GG12308@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408150610.28139.gene.heskett@verizon.net> <20040815103743.GF12308@parcelfarce.linux.theplanet.co.uk> <200408150642.12007.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408150642.12007.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 06:42:11AM -0400, Gene Heskett wrote:
> On Sunday 15 August 2004 06:37, viro@parcelfarce.linux.theplanet.co.uk 
> wrote:
> >On Sun, Aug 15, 2004 at 06:10:28AM -0400, Gene Heskett wrote:
> >> all in one line of text, its a bit hard to locate real duplicates.
> >> But I think I see some right now!  Can this line be modified to
> >> spit them out, one entry per line with all dups sorted to be
> >> adjacent?
> >
> >Sure, just add \n in format here.  Sorry, hadn't noticed that...
> >
> >> >+	seq_printf(m, "%d:%d:%lu:%o",
> 
> Can do, assume it would then be seq_printf(m, "%d:%d:%lu:%o\n"?

Yes
