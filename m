Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269443AbUJLEMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269443AbUJLEMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 00:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269445AbUJLEMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 00:12:31 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:1664 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S269443AbUJLELR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 00:11:17 -0400
Date: Tue, 12 Oct 2004 07:11:15 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Andrew Morton <akpm@osdl.org>, roland@redhat.com, joshk@triplehelix.org,
       linux-kernel@vger.kernel.org
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-ID: <20041012041115.GA322@elektroni.ee.tut.fi>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, roland@redhat.com,
	joshk@triplehelix.org, linux-kernel@vger.kernel.org
References: <20041010211507.GB3316@triplehelix.org> <200410112055.i9BKt5LI031359@magilla.sf.frob.com> <20041012033934.GA275@elektroni.ee.tut.fi> <20041011205233.5fe4f99f.akpm@osdl.org> <20041012035634.GB665@elektroni.ee.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012035634.GB665@elektroni.ee.tut.fi>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 06:56:34AM +0300, Petri Kaukasoina wrote:
> On Mon, Oct 11, 2004 at 08:52:33PM -0700, Andrew Morton wrote:
> > Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi> wrote:
> > > wait4(-1073750328, NULL, 0, NULL)       = -1 ECHILD (No child processes)
> > > 
> > > But the whole problem goes away if I switch CONFIG_REGPARM off. To reproduce
> > > it needs CONFIG_REGPARM=y.
> > > 
> > 
> > And what compiler version are you using?
> > 
> 
> gcc 3.4.2.

And the problem also exists on a kernel compiled with gcc 3.3.4.
