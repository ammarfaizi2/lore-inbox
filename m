Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbTEDAju (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 20:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTEDAju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 20:39:50 -0400
Received: from [81.68.134.96] ([81.68.134.96]:6917 "EHLO drinkel.cistron.nl")
	by vger.kernel.org with ESMTP id S263480AbTEDAjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 20:39:49 -0400
Date: Sun, 4 May 2003 02:53:46 +0200
From: Miquel van Smoorenburg <miquels@cistron-office.nl>
To: =?iso-8859-1?B?UOVs?= Halvorsen <paalh@ifi.uio.no>
Cc: Mark Mielke <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org,
       =?iso-8859-1?B?UOVs?= Halvorsen <paalh@ifi.uio.no>,
       miquels@cistron-office.nl
Subject: Re: sendfile
Message-ID: <20030504005346.GP32553@drinkel.cistron.nl>
References: <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no> <20030430221834.GA23109@mark.mielke.cc> <Pine.SOL.4.51.0305010024180.334@niu.ifi.uio.no> <20030501042831.GA26735@mark.mielke.cc> <Pine.SOL.4.51.0305012303540.17001@fjorir.ifi.uio.no> <3EB1A029.7080708@nortelnetworks.com> <20030502024147.GA523@mark.mielke.cc> <3EB1F1CD.4060702@nortelnetworks.com> <20030502210648.GA5322@mark.mielke.cc> <Pine.SOL.4.51.0305032253490.18740@fjorir.ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.SOL.4.51.0305032253490.18740@fjorir.ifi.uio.no>; from paalh@ifi.uio.no on Sat, May 03, 2003 at 23:01:21 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 May 2003 23:01:21, Pål Halvorsen wrote:
> 
> > Sat, May 03, 2003 at 12:42:59AM +0000, Miquel van Smoorenburg wrote:
> > > In article <20030502210648.GA5322@mark.mielke.cc>,
> > > Mark Mielke  <mark@mark.mielke.cc> wrote:
> > > >One question it raises in my mind, is whether there would be value
> in
> > > >improving write()/send() such that they detect that the userspace
> > > >pointer refers entirely to mmap()'d file pages, and therefore no
> copy
> > > >of data from userspace -> kernelspace should be performed.
> > > You mean like
> > >
> >  
> http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week00/0056.html
> >
> > Yes, definately, and thank you for referring us to work that has
> already
> > been done.
> >
> > mark
> 
> Does this mean that if you memory map a file and send it through TCP,
> you'll have no copy operations transfering data from disk to NIC (except
> the DMS transfers disk->memory and memory->NIC)?

No. I just referred to an earlier discussion about this topic. That does't
mean it has been implemented. In fact if you actually read that discussion
you'll see that it probably won't be implemented at all.
  Mike.
-- 
| Miquel van Smoorenburg        | "I know one million ways, to always pick 
|
| miquels@{drinkel.,}cistron.nl |  the wrong fantasy" - the Black Crowes.  
|
