Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287353AbSACQFH>; Thu, 3 Jan 2002 11:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287361AbSACQE5>; Thu, 3 Jan 2002 11:04:57 -0500
Received: from svr3.applink.net ([206.50.88.3]:36112 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287353AbSACQEt>;
	Thu, 3 Jan 2002 11:04:49 -0500
Message-Id: <200201031604.g03G4BSr025877@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, cs@zip.com.au
Subject: Cryto verification of Kernel against Trojan code??
Date: Thu, 3 Jan 2002 10:00:28 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Lionel.Bouton@free.fr (Lionel Bouton),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de (Dave Jones)
In-Reply-To: <E16M75s-0008Bz-00@the-village.bc.nu>
In-Reply-To: <E16M75s-0008Bz-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 January 2002 06:35, Alan Cox wrote:
> > 	  binary may have bugs, security holes, race conditions etc; it may be
> > 	  hacked post boot (no so easy to do to the live kernel image), etc
>
> Just like the kernel, only the binary is a little less dangerous. Hacking
> live kernel images is trivial also btw. There are tools for it.

And that brings me to my crazy thought for the day.   System.map is
what is says, a map of the system.   Would it make any sense to compute
an md5 hash on it and use it as a means of verifying that the kernel is
clean from tampering?  (That's assuming that the hackers didn't replace
syscalls with a trojan with exactly the same size and same location.)



-- 
timothy.covell@ashavan.org.
