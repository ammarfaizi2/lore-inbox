Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbULTTtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbULTTtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 14:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbULTTtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 14:49:14 -0500
Received: from fsmlabs.com ([168.103.115.128]:40410 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261628AbULTTtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 14:49:02 -0500
Date: Mon, 20 Dec 2004 12:49:01 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Rudolf Usselmann <rudi@asics.ws>
cc: "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: kernel (64bit) 4GB memory support
In-Reply-To: <1103213359.31392.71.camel@cpu0>
Message-ID: <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com>
References: <41BAC68D.6050303@pobox.com> <1102760002.10824.170.camel@cpu0> 
 <41BB32A4.2090301@pobox.com> <1102824735.17081.187.camel@cpu0> 
 <Pine.LNX.4.61.0412112141180.7847@montezuma.fsmlabs.com> 
 <1102828235.17081.189.camel@cpu0>  <Pine.LNX.4.61.0412120131570.7847@montezuma.fsmlabs.com>
  <1102842902.10322.200.camel@cpu0>  <Pine.LNX.4.61.0412120934160.14734@montezuma.fsmlabs.com>
  <1103027130.3650.73.camel@cpu0>  <20041216074905.GA2417@c9x.org>
 <1103213359.31392.71.camel@cpu0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Rudolf Usselmann wrote:

> On Thu, 2004-12-16 at 14:49, Frank Denis (Jedi/Sector One) wrote:
> > On Tue, Dec 14, 2004 at 07:25:31PM +0700, Rudolf Usselmann wrote:
> > > Actually I tried "2.6.10-rc3" a few days ago, and had the same
> > > results. Do you still want me to try "2.6.10-rc2-mm4" ?
> > 
> >   Yes, try 2.6.10-rc2-mm4 and apply add this patch:
> >   
> > ftp://ftp.c9x.org/linux-kernel/2.6.10-rc2/2.6.10-rc2-mm4/2.6.10-rc2-mm4-jedi4.patch.bz2
> > 
> >   Does it work?
> 
> Hi Frank,
> 
> no unfortunately it did not work.
> 
> The "panics" are different, the kernel seems to be able to
> recover from panics ... 
> 
> Attached is an archive with ver_linux output, my config file,
> and a log file. You might find this to be more useful this time,
> as I was able to do several things to make it "crash" at one
> point I did a remote login in to this computer and that caused
> a crash as well. Definitely a lot more crashes I was able to
> capture ....

Rudolf, thanks for collecting that information. Since you said that 
2.6.10-rc3 also had similar results it counts out a number of suspects i 
had in the -mm tree. Could you work towards isolating a working kernel 
version? You could try these;

2.6.8.1
2.6.9
2.6.9-mm1

Thanks,
	Zwane
