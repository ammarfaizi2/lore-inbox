Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280053AbRJaEUO>; Tue, 30 Oct 2001 23:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280056AbRJaEUE>; Tue, 30 Oct 2001 23:20:04 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:783 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S280053AbRJaETr>;
	Tue, 30 Oct 2001 23:19:47 -0500
Message-Id: <200110310420.f9V4KKY17101@aslan.scsiguy.com>
To: "Florin Iucha" <florin@iucha.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: scsi lockup with adaptec and advansys 
In-Reply-To: Your message of "Tue, 30 Oct 2001 19:55:28 CST."
             <20011030195527.A24642@beaver.iucha.org> 
Date: Tue, 30 Oct 2001 21:20:20 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello!
>
>Kernel version: 2.4.14-pre5

...

>I am experiencing a kernel lockup under load: I am running three md5sum 
>processes on the Mandrake .iso files, starting mozilla and playing an
>.mpg clip with vlc.

What kind of system is this?

Can you reproduce this on older kernels?  With the aic7xxx_old driver?
With older versions of the "new" aic7xxx driver?

Since you are seeing "strange things" on two different controller types
this smells like random memory corruption.  With some experimentation
with different kernel and driver versions, you might expose a pattern
that helps track down what is going on.

--
Justin
