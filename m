Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTKRJYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 04:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTKRJYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 04:24:17 -0500
Received: from CPE-138-130-214-20.qld.bigpond.net.au ([138.130.214.20]:25020
	"EHLO mx.jeeves.bpa.nu") by vger.kernel.org with ESMTP
	id S262386AbTKRJYQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 04:24:16 -0500
From: Ben Hoskings <ben@jeeves.bpa.nu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 yenta_socket eats kernel time on Toshiba Laptop
Date: Tue, 18 Nov 2003 19:24:10 +1000
User-Agent: KMail/1.5.93
References: <43376.138.130.214.20.1068871325.squirrel@jeeves.home.house> <20031115015927.4e31e6ee.akpm@osdl.org> <200311161011.03804.ben@jeeves.bpa.nu>
In-Reply-To: <200311161011.03804.ben@jeeves.bpa.nu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200311181924.10765.ben@jeeves.bpa.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Nov 2003 10:11 am, Ben Hoskings wrote:
> Thanks for the reply, Andrew.
>
> > >  Attepting a modprobe on any of the other PCMCIA bus drivers gives a
> > >  'device not found' error.
> > >
> > >  Under 2.4, the PCMCIA bus uses the i82365 module, which works
> > > perfectly. Under 2.6, it appears that the related driver has been
> > > moved to the yenta_socket module (It's a ToPIC100 Controller; see dmesg
> > > below).
> >
> > Have you tried disabling i82365 in kernel config?
> 
> All the PCMCIA options are configured as modules, and when I modprobed 
> yenta_socket, the only one already loaded was pcmcia_core. Disabling in the
>  kernel config won't make a difference here will it?
> 
Anyone else have any suggestions on what I could do to start debugging this 
problem? I don't like to ask again, but I figure this is too good a chance to 
miss.
I'd like to get my laptop working with 2.6, sure, but more importantly a 
problem like this that affects hardware I own is the perfect chance for me to 
poke my head into the kernel sources and start learning. ;)


ben_h
