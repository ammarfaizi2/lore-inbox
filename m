Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVBSRzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVBSRzz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 12:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVBSRzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 12:55:55 -0500
Received: from a213-22-240-12.netcabo.pt ([213.22.240.12]:50821 "EHLO
	sergiomb.no-ip.org") by vger.kernel.org with ESMTP id S261751AbVBSRzc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 12:55:32 -0500
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov
X-Antivirus-bastov: 1.24-st-qms (Clear:RC:1(192.168.1.2):. Processed in 0.339709 secs Process 26790)
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and
	give	dev=/dev/hdX as device
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, karl.kiniger@med.ge.com,
       Valdis.Kletnieks@vt.edu,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       kernel <kernel@crazytrain.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1108499791.11356.9.camel@bastov>
References: <1108426832.5015.4.camel@bastov>
	 <1108434128.5491.8.camel@bastov>  <42115DA2.6070500@osdl.org>
	 <1108486952.4618.10.camel@localhost.localdomain>
	 <1108499791.11356.9.camel@bastov>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 19 Feb 2005 17:55:08 +0000
Message-Id: <1108835709.26083.35.camel@bastov>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well , In other computer with one fresh Core 3 installation, try set a
prodvd.key on xcdroast, Fedora Core 3, doesn't had set hdc=ide-scsi , so
I think that the recorder of dvds has worked in mode hdc=ide-cd, and
stopped to function and to read any type of cd or dvd.
So is it possible that ide-cd had, damage my dvdrecorder ? 

Well dvdrecorder doesn't had work very well all the time, even in
Windows, and stops after one firmware upgrade but I hadn't much luck.
Happily it is in the warranty.

--------------------------------------------------------------------------
On Thu, 2005-02-17 at 02:27 +0000, Sergio Monteiro Basto wrote:
with hdc=scsi haldeamon doesn't recognize cdwriter.
but with hdc=ide-scsi (was the original from kernel 2.4) haldaamon
reconize my cdwriter !

So this message of this subject just make me wast my time and lose my
patience. ( because I forgot to enable haldaemon before to try
understand the message ) 
Still don't understand if I should or not change to ide-cd on my FC3, if
not please remove the message, if yes rewrite it please .

thanks for your precious time.

On Tue, 2005-02-15 at 20:36 +0000, Sergio Monteiro Basto wrote:
> Well the problem for the common users is the haldeamon doesn't recognize
> automatically /dev/scd0 and /etc/fstab don't have any entry about it.
> 
> So with hdc=scsi, how I read cds on hdc ?
> 
> thanks,
> 
> Note: I am using last updates of FC3, after upgrade from FC1. 
> 
> 
> On Tue, 2005-02-15 at 17:02 +0000, Alan Cox wrote:
> > On Maw, 2005-02-15 at 02:25, Randy.Dunlap wrote:
> > > It means:  don't use the ide-scsi driver.  Support for it is
> > > lagging (not well-maintained) because it's really not needed for
> > > burning CDs.  Just use the ide-cd driver (module) and
> > > specify the CD burner device as /dev/hdX.
> > 
> > This information is unfortunately *WRONG*. The base 2.6 ide-cd driver is
> > vastly inferior to ide-scsi. The ide-scsi layer knows about proper error
> > reporting, end of media and other things that ide-cd does not.
> > 
> > The -ac ide-cd knows some of the stuff that ide-cd needs to and works
> > with various drive/disk combinations the base code doesn't but ide-scsi
> > still handles CD's better.
> > 
> > Alan
> > 
-- 
Sérgio M.B.

