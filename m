Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbUBTQxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 11:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbUBTQxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 11:53:50 -0500
Received: from pat.uio.no ([129.240.130.16]:41360 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261338AbUBTQxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 11:53:48 -0500
To: linux-kernel@vger.kernel.org
Subject: SATA hotswap with libata?
From: Terje Kvernes <terjekv@math.uio.no>
Organization: The friends of mr. Tux
X-URL: http://terje.kvernes.no/
Date: Fri, 20 Feb 2004 17:53:40 +0100
Message-ID: <wxxu11lg0a3.fsf@nommo.uio.no>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I've been testing a box with RAID1 in software, and thought I'd have
  a look at the possibility of hotswap.  with "normal" PATA (ie, not
  libata) I would have tried to fiddle with hdparm -U / -R, but trying
  that with a drive using libata (and showing up as sd*) nothing
  happens.  this isn't much of a surprise, but I don't seem to find
  any other suggestions on how to do hotswap with IDE drives.

  the hardware in question is a Promise SATA 150 TX4 (without any RAID
  support), with two WD 1200JD drives attached.  Promise "SuperSwap
  1100"[1] canisters hold the drives and make them easy to plug in and
  out.  / and /boot is located on these drives, using lilo 22.5.8 to
  boot from the RAIDset.

  the current kernel being run is 2.4.24 with patches for libata and
  skas3 (the box will hopefully run some user-mode images in the near
  future).  all my other boxes run 2.6, but the possible acquisition
  of a PVR-350 card and the lack of 2.6 support for ivtv makes me want
  to live on 2.4 if it can be done.

  I'll be more than happy to test kernels, patches and pretty much
  anything that might help.



  [1] the "SuperSwap 1100" should be called "Plastic Fantastic".  it's
      really depressing to work with, but it sort of does it's job.  I
      suppose that's worth something, although it's not worth what one
      pays for the canisters.  *sigh*

-- 
Terje
