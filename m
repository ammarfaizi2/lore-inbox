Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262103AbSIPOiZ>; Mon, 16 Sep 2002 10:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262113AbSIPOiZ>; Mon, 16 Sep 2002 10:38:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49161 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262103AbSIPOiY>; Mon, 16 Sep 2002 10:38:24 -0400
Date: Mon, 16 Sep 2002 15:43:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: venom@sns.it, louie miranda <louie@chikka.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hi is this critical??
Message-ID: <20020916154316.A23094@flint.arm.linux.org.uk>
References: <Pine.LNX.4.43.0209161537200.5180-100000@cibs9.sns.it> <1032184041.7199.14.camel@bip>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1032184041.7199.14.camel@bip>; from xavier.bestel@free.fr on Mon, Sep 16, 2002 at 03:47:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 03:47:20PM +0200, Xavier Bestel wrote:
> Le lun 16/09/2002 à 15:37, venom@sns.it a écrit :
> > 
> > yes, this is critical.
> > It means that your HD is going to break soon.
> > 
> 
> Maybe these error messages should be a bit less cryptic for the
> uninitiated. Or is there a userspace utility to convert theses to
> luser-understandable messages ?

I had a patch in the Daleki 2.5 IDE which would easily allow for
alternative descriptions to be added with very little pain.

The patch was really trivial, and converted the code that gives
these messages into a data structure instead.  (A good balance
between data structures and code is an important point IMHO.)

However, due to the method by which Martins stuff was ripped out
of the kernel, its going to be pretty hard for me to recover the
patch.  I was hoping BK might help here, but it doesn't appear
to.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

