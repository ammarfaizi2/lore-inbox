Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTJFRlE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTJFRlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:41:04 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:19719
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262424AbTJFRky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:40:54 -0400
Date: Mon, 6 Oct 2003 10:40:52 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jesper Juhl <jju@dif.dk>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 71MB compressed for COMPILED(!!!) 2.6.0-test6
Message-ID: <20031006174052.GA2190@matchmail.com>
Mail-Followup-To: Jesper Juhl <jju@dif.dk>,
	Matthias Andree <matthias.andree@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20031006082340.GA1135@matchmail.com> <1065428996.5033.5.camel@laptop.fenrus.com> <20031006083803.GB1135@matchmail.com> <20031006102415.GB7598@merlin.emma.line.org> <Pine.LNX.4.56.0310061655070.26687@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0310061655070.26687@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 05:24:48PM +0200, Jesper Juhl wrote:
> 
> On Mon, 6 Oct 2003, Matthias Andree wrote:
> 
> > On Mon, 06 Oct 2003, Mike Fedyk wrote:
> >
> > > config DEBUG_INFO
> > > 	bool "Compile the kernel with debug info"
> > > 	depends on DEBUG_KERNEL
> > > 	help
> > >           If you say Y here the resulting kernel image will include
> > > 	  debugging info resulting in a larger kernel image.
> > > 	  Say Y here only if you plan to use gdb to debug the kernel.
> > > 	  If you don't debug the kernel, you can say N.
> > >
> > > "Larger kernel image" yeah, NO SHIT! ;)
> > >
> > > Maybe something that says it may enlarge your kernel by 5-10 times would be
> > > nice...
> >
> > Send a patch...
> >
> 
> How about this one?  :

Looks good to me, but why is this config option arch specific?  Are there
any archatectures that don't support DEBUG_INFO?
