Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287042AbRLaIbp>; Mon, 31 Dec 2001 03:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287159AbRLaIbf>; Mon, 31 Dec 2001 03:31:35 -0500
Received: from olinz-dsl-1316.utaonline.at ([212.152.239.38]:20462 "EHLO
	falke.mail") by vger.kernel.org with ESMTP id <S287015AbRLaIb1>;
	Mon, 31 Dec 2001 03:31:27 -0500
Message-ID: <3C302161.9DED4550@falke.mail>
Date: Mon, 31 Dec 2001 09:27:13 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SIS-Driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 10.0.0.13
X-Return-Path: tw@webit.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > What am I doing wrong, or is that a bug? I solved it by setting up a 
> > Kernel with all SIS-DRM included, compile X and then removed them. ATM 
> > I am unable to test if the SIS-DRM really runs with that 
> > configuration... 
>
> If X is poking around in the kernel configuration and 
> requires it built in then report the problem to the XFree86 people. For 
> the SiS DRM you do need SiS framebuffer currently

Yeah... currently. But the sisfb code won't mess up the console any
longer if you use my new driver available at
http://linux-sis630.decode.info (eventually with "mode=none").

Together with my patch for the SiS-DRM module (available at the same
place) DRI runs perfectly.

I proposed the driver and the patch to be included in the kernel - yet
unsuccessfully...

Thomas

-- 
Thomas Winischhofer
Vienna/Austria                  Check it out:
mailto:tw@webit.com              http://www.webit.com/tw

