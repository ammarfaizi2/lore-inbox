Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSINVrQ>; Sat, 14 Sep 2002 17:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSINVrQ>; Sat, 14 Sep 2002 17:47:16 -0400
Received: from m5-real.eastlink.ca ([24.222.0.25]:25804 "EHLO m5.andara.com")
	by vger.kernel.org with ESMTP id <S317571AbSINVrP>;
	Sat, 14 Sep 2002 17:47:15 -0400
From: "Alan Miles" <alanmiles@hfx.eastlink.ca>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Patrick J. Volkerding" <volkerdi@slackware.com>, <Riley@Williams.Name>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Problem with 2.4.19/2.4.20-pre7 multiple root floppy disks-2.4.18 works.
Date: Sat, 14 Sep 2002 18:51:51 -0300
Message-ID: <JLEBIHHBMBHBAFPAJLEFCECLDAAA.alanmiles@hfx.eastlink.ca>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1032035275.13636.15.camel@irongate.swansea.linux.org.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Thanks for your reply - I appreciate all the hard work you guys are doing.

My experience to-date with the kernel is to compile it - not to try and fix
something. However, I could try and fix it,
although I feel it would be better for the kernel maintainers to fix it, as
I am inexperienced with Linux kernel level
programming; I come from an application programming arena.

Pat, I am cc'ing you on this so you know what is going on - this is the
root-disk problem that I emailed you about.

Alan

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: September 14, 2002 17:28
To: Alan Miles
Cc: linux-kernel@vger.kernel.org; Riley@Williams.Name
Subject: Re: Problem with 2.4.19/2.4.20-pre7 multiple root floppy
disks-2.4.18 works.


On Fri, 2002-09-13 at 21:08, Alan Miles wrote:
> I reported this problem with 2.4.19 and have just tested the 2.4.20-pre7
> kernel. The same problem exists there.
> I must re-iterate that 2.4.18 works fine with all of my 7 uncompressed
> 1.44MB floppy disks, and the 2.4.18 system boots up fine.

Yes its in my bug list. Its up to someone it matters to to provide
patches. It could be a ramdisk change. it could well come from the
initrd loading cleanup/root ramfs stuff.

