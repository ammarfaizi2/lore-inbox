Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273308AbRINGAr>; Fri, 14 Sep 2001 02:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273306AbRINGAh>; Fri, 14 Sep 2001 02:00:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50499 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S273307AbRINGAU>; Fri, 14 Sep 2001 02:00:20 -0400
To: Chris Vandomelen <chrisv@b0rked.dhs.org>
Cc: <linux-kernel@vger.kernel.org>, VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Athlon bug stomping #2
In-Reply-To: <Pine.LNX.4.31.0109132101210.10262-100000@linux.local>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Sep 2001 23:51:58 -0600
In-Reply-To: <Pine.LNX.4.31.0109132101210.10262-100000@linux.local>
Message-ID: <m1d74utj41.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Vandomelen <chrisv@b0rked.dhs.org> writes:

> > On Thu, 13 Sep 2001, VDA wrote:
> >
> > > Device 0 Offset 55 - Debug (RW)
> > > 7-0 Reserved (do not program). default = 0
> > > *** 3R BIOS: non-zero!?
> > > *** YH BIOS: zero.
> > > *** TODO: try to set to 0.
> >
> > I tryed sequentially to test the values given. It only worked when I set
> > offset 0x55 to 0, and then stopped. I don't need to set any other value in
> > other addresses. This is enough.
> >
> > It's weird when your system only works when changing a "do not
> > program" value. :)
> 
> Makes me wonder just a little: my system is perfectly fine with 0x02
> written to offset 0x55. (Yes, it is an Athlon compiled kernel.. something
> I've been doing ever since I've been using this machine). It had it's
> problems when I originally got it

So we have two confirmations that setting this register clears the problem.
Anyone want to generate a kernel patch so this fix can get some wider
testing?

Eric
