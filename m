Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287297AbSACOZW>; Thu, 3 Jan 2002 09:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287299AbSACOZN>; Thu, 3 Jan 2002 09:25:13 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:35001 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287297AbSACOZA>; Thu, 3 Jan 2002 09:25:00 -0500
Date: 03 Jan 2002 12:34:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8GBXFw6mw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.33.0201030006120.427-100000@Appserv.suse.de>
Subject: Re: ISA slot detection on PCI systems?
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20020102174824.A21408@thyrsus.com> <Pine.LNX.4.33.0201030006120.427-100000@Appserv.suse.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de (Dave Jones)  wrote on 03.01.02 in <Pine.LNX.4.33.0201030006120.427-100000@Appserv.suse.de>:

> And if you don't know what hardware you've got in the box your
> configuring a kernel for, its questionable that you should be
> doing so in the first place.

IME, not knowing that exactly is the rule rather than the exception.  
There's a reason we have autodetect code in all sorts of software,  
including the Linux kernel.

Now, if we cannot reliably autodetect hardware, we should always make it  
possible to override this manually, and maybe also inform the user that  
we're not certain. But that's no excuse not to try to autodetect when the  
user has *not* overridden us.

MfG Kai
