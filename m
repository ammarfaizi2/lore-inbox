Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276765AbRJCRxo>; Wed, 3 Oct 2001 13:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276807AbRJCRxf>; Wed, 3 Oct 2001 13:53:35 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:25355 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S276765AbRJCRx0> convert rfc822-to-8bit; Wed, 3 Oct 2001 13:53:26 -0400
Date: Wed, 3 Oct 2001 19:53:53 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [POT] Which journalised filesystem ?
Message-ID: <20011003195353.B3188@emma1.emma.line.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0110030938130.4835-100000@imladris.rielhome.conectiva> <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de> <20011003190315.G21866@emma1.emma.line.org> <1002130880.10919.0.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1002130880.10919.0.camel@nomade>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Oct 2001, Xavier Bestel wrote:

> le mer 03-10-2001 at 19:03 Matthias Andree a écrit :
> > On Wed, 03 Oct 2001, Dave Jones wrote:
> > 
> > > Alan mentioned this was something to do with the IBM hard disk
> > > having strange write-cache properties that confuse ext3.
> > 
> > hdparm -W0 /dev/hda is your friend.
> 
> Unfortunately I think IDE drives don't honor this setting - write-cache
> is always on.

It's meant for IDE drives, and the write cache has been in the feature 
register for ages. Just try it, you'll notice if it fails.

BTW, it works as expected on my DJNA, DPTA, DTLA drives, and I know you
can turn the cache of DARA drives off as well.

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
