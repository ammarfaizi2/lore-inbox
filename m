Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263101AbTCSQms>; Wed, 19 Mar 2003 11:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263100AbTCSQms>; Wed, 19 Mar 2003 11:42:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19589
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263093AbTCSQmS>; Wed, 19 Mar 2003 11:42:18 -0500
Subject: Re: problem with pcmcia, pci and hard disk
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mauro Chiarugi <maurochiarugi@tiscali.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030319174705.37994a18.maurochiarugi@tiscali.it>
References: <20030319173523.745fb4a9.maurochiarugi@tiscali.it>
	 <20030319174705.37994a18.maurochiarugi@tiscali.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048097045.30751.64.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Mar 2003 18:04:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 16:47, Mauro Chiarugi wrote:
> I forgot to explain why in the subject i've written hard disk too..
> When, at the boot, every 27 times, it check the file system, some times
> (or every time, i don't sure..) it fails... :-( I use ext3.

It should never be failing, on 2.4.18 or 2.5.x with ext3. You should
get log playbacks on a crash and maybe an fsck every 27 if you set the
checking to run that way.

My first guess is you have something corrupting data - bad memory, bad
disk, overclocking or of course a software bug that you happen to hit
and nobody else seems to.

What drivers are you running

