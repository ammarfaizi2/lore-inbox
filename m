Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUDGOXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUDGOXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:23:36 -0400
Received: from mail.cyclades.com ([64.186.161.6]:65500 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263665AbUDGOXd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:23:33 -0400
Date: Wed, 7 Apr 2004 11:02:54 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Who maintains the atp870u driver? (ACARD PCI SCSI)
Message-ID: <20040407140254.GB10979@logos.cnet>
References: <40702B87.6080506@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40702B87.6080506@longlandclan.hopto.org>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 01:36:39AM +1000, Stuart Longland wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi All,
> 	Does anyone still maintain the atp870u SCSI driver, and if so, is it
> possible for them to contact me?  I had a look in the atp870u.c file --
> if I read this correctly, this driver hasn't changed much in the last
> few years.  (Last log entry was in 2001).
> 
> 	Basically, I recently acquired a PCI ACARD SCSI card (can't recall 
> 	what
> chipset exactly) and decided to use that in a Gateway Microserver server
> appliance I had laying around.  The intent was to plug it into an
> external tower of hard drives to make a nice compact fileserver for lans.
> 
> 	The machine is a clone of the Cobalt Qube 2 (2800) server appliance,
> running a 250MHz (?) MIPS "Nervada" R5200 CPU, 64MB EDO RAM, and 10GB
> IBM IDE HDD internal.  It has one PCI slot, attached to a Galileo PCI
> controller.  When first bought, it had a Lucent Winmodem installed
> (Gateway branded).  All I've done is simply replaced the modem with this
> SCSI card.  The box is running Debian 3.0 with Linux Kernel 2.4.24-pre2
> (from linux-mips CVS).
> 
> 	If I fire the box up, then run 'modprobe atp870u' -- with no devices
> attached (or switched off), the driver loads, no worries.  However, if I
> try doing the same with a device attached (and switched on), I get SCSI
> timeout errors, and the driver initialisation stalls. -- I have to
> reboot to unload the driver. (See attachment)
> 
> 	The device in question is the tower of hard drives I mentioned above
> (has 3x 18.2GB and 1x 9.1GB HDDs).  I know from previous testing that
> neither the tower, the cable nor the terminator are at fault -- they
> work just fine on both an SGI Indy and my main machine (with an Advansys
> SCSI card) without any hassles.  I have also tried plugging in an
> external tape drive, and got the same results.
> 
> 	The only thing that I haven't tested is whether the card works (it 
> 	was
> sold second hand with a CDRW burner -- I presumed it did, and from the
> tests tonight, there's at least a little bit of life), and what its
> compatability is with Linux (in particular Linux/MIPS).  I've also tried
> an Advansys SCSI card (the one in my main box) in the same machine with
> no joy (it didn't work _at all_ -- so the ACARD host is currently doing
> better right now)
> 
> 	I'm not able to hack the driver myself, as I'm a newbie when it comes
> to kernel hacking. (Otherwise I'd be looking into it right
> now...unfortunately I'm a C newbie, and therefore the code is right over
> my head.)  I might also later try the Linux-MIPS crew if this turns out
> to be a MIPS-specific thing (I can't rule that one out).
> 
> Any assistance would be appreciated,

No one really maintains it officially.

James Bottomley and Doug Ledford have done some fixes for it on v2.6, you might want 
trying to ask them directly.

Sorry.
