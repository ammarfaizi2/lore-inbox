Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267636AbUG3Gqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267636AbUG3Gqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 02:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267635AbUG3Gqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 02:46:31 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:57866 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267636AbUG3Gq1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 02:46:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crash(s)?
Date: Fri, 30 Jul 2004 09:45:47 +0300
X-Mailer: KMail [version 1.4]
Cc: "Randy.Dunlap" <rddunlap@osdl.org>
References: <200407242156.40726.gene.heskett@verizon.net> <20040729203603.1023ed38.rddunlap@osdl.org> <200407300050.53523.gene.heskett@verizon.net>
In-Reply-To: <200407300050.53523.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200407300945.47019.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >| >make fs/dcache.s
> >|
> >| Aha!  Voila!! It doesn't work in the "fs" subdir, but back out to
> >| the top of the src tree and it works just fine.  Duh...
> >
> >Right, it needs the top-level makfile and kbuild machinery to do
> > that.
> >
> >| Now, I must confess that what I'm looking at in those two files is
> >| the .s is the source assembly that would normally be fed to gas,
> >| and the objdump'ed version is the dissed object translated back to
> >| gas source.  If no mistakes, they should be pretty close to the
> >| same I'd think.  Am I on the right track?  Or full of it?
> >
> >Yes, right.
>
> Which?
>
> Right track, or full of it? :-)
>
> In any event, I could send those two files along if you'd like, I'm
> not an assembly guru on "amd/intel" chips, not even in my wildest
> dreams .

Send them, along with oops.

BTW, compile 'oops-hunting' kernels with frame pointers in the future
(I just compile all my kernels with it).
--
vda
