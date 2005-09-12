Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVILNJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVILNJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVILNJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:09:50 -0400
Received: from nevyn.them.org ([66.93.172.17]:10664 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1750806AbVILNJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:09:49 -0400
Date: Mon, 12 Sep 2005 09:09:46 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Jan Beulich <JBeulich@novell.com>, Tom Rini <trini@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 CFI annotations
Message-ID: <20050912130946.GA27817@nevyn.them.org>
Mail-Followup-To: Jan Beulich <JBeulich@novell.com>,
	Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
References: <432070850200007800024465@emea1-mh.id2.novell.com> <20050908154645.GN3966@smtp.west.cox.net> <43207BA30200007800024502@emea1-mh.id2.novell.com> <20050908161334.GP3966@smtp.west.cox.net> <43214D2D02000078000247B5@emea1-mh.id2.novell.com> <20050910055836.GA28662@twiddle.net> <4325448C0200007800024DF5@emea1-mh.id2.novell.com> <20050912074914.GA31047@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912074914.GA31047@twiddle.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 12:49:14AM -0700, Richard Henderson wrote:
> On Mon, Sep 12, 2005 at 09:04:12AM +0200, Jan Beulich wrote:
> > But truly I think the processor-specific pieces of Dwarf's
> > frame unwind spec should provide numbering for the complete set of
> > registers.
> 
> Except there is no standards body for this.  So *someone* will
> have to make it up.
> 
> Make it up and put it in gas and gdb: that will make it a defacto standard.

Agreed.  If it makes you feel better, we could ask the DWARF committee to
maintain a repository of processor-specific documents.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
