Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSHRWmA>; Sun, 18 Aug 2002 18:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSHRWmA>; Sun, 18 Aug 2002 18:42:00 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:23006 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S316465AbSHRWl7>; Sun, 18 Aug 2002 18:41:59 -0400
Subject: Re: Alloc and lock down large amounts of memory
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1029673097.15859.19.camel@irongate.swansea.linux.org.uk>
References: <23B25974812ED411B48200D0B774071701248520@exchusa03.intense3d.com> 
	<1029672587.12504.88.camel@sake> 
	<1029673097.15859.19.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 01:45:38 +0300
Message-Id: <1029710739.15645.66.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 15:18, Alan Cox wrote:
> On Sun, 2002-08-18 at 13:09, Gilad Ben-Yossef wrote:
> > >     Can 256M be allocated using vmalloc, if so is it swappable?
> > 
> > It can be alloacted via vmalloc and AFAIK it is not swappable by
> > default. This doesn't sound like a very good idea though.
> 
> There isnt enough address space for vmalloc to grab 256Mb. If you want
> that much then you need to handle the fact its in page arrays not
> virtually linear yourself.

Oopss... indeed. 256M is twice the entire vmalloc address space to be
exact. 

Thanks for correcting my mistake ;-)

Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

"Money talks, bullshit walks and GNU awks."
  -- Shachar "Sun" Shemesh, debt collector for the GNU/Yakuza

