Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261843AbSIXXOW>; Tue, 24 Sep 2002 19:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbSIXXOW>; Tue, 24 Sep 2002 19:14:22 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:37367 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261843AbSIXXOU>; Tue, 24 Sep 2002 19:14:20 -0400
Date: Tue, 24 Sep 2002 19:19:34 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UP IO-APIC
Message-ID: <20020924191934.B2453@redhat.com>
References: <Pine.LNX.4.44.0209240331280.20792-100000@montezuma.mastecende.com> <Pine.GSO.4.33.0209241119500.11624-100000@sweetums.bluetronic.net> <amq996$46e$2@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <amq996$46e$2@ncc1701.cistron.net>; from miquels@cistron.nl on Tue, Sep 24, 2002 at 06:01:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 06:01:10PM +0000, Miquel van Smoorenburg wrote:
> In article <Pine.GSO.4.33.0209241119500.11624-100000@sweetums.bluetronic.net>,
> Ricky Beam  <jfbeam@bluetronic.net> wrote:
> >The local
> >APIC makes perfect sense albeit rare.  Single processor IO APICs are very
> >rare and are usually MP systems with only one processor.
> 
> I think most AMD Athlon boards have an IO APIC

I'd love to have it enabled in a distro kernel, but as Arjan pointed out, it 
currently breaks some laptops if enabled.  What we need is someone to weed 
things out such that io apic setup gets done after command line parsing, but 
that is a bit tricky...

		-ben
