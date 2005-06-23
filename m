Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVFWUn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVFWUn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbVFWUnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:43:22 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63204 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262666AbVFWUmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:42:52 -0400
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
From: Lee Revell <rlrevell@joe-job.com>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: abonilla@linuxwireless.org, "'Vojtech Pavlik'" <vojtech@suse.cz>,
       borislav@users.sourceforge.net, "'Pavel Machek'" <pavel@ucw.cz>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org,
       notlug@paul.sladen.org
In-Reply-To: <42BB19EB.1060202@tremplin-utc.net>
References: <004001c577f2$865ab650$600cc60a@amer.sykes.com>
	 <42BB19EB.1060202@tremplin-utc.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 23 Jun 2005 16:42:46 -0400
Message-Id: <1119559367.20628.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-23 at 22:22 +0200, Eric Piel wrote:
> 06/23/2005 02:53 PM, Alejandro Bonilla wrote/a écrit:
> Just to add a few more cents, googling around I found that Paul Sladen 
> has already been looking for some info on the chip. Started to RE the 
> windows driver, this kind of info _might_ be useful :
> Windows drivers read in 28-bytes via an IOCTL(0x733fc) on "\ShockMgr" . 
>   (See shockprf.sys)
> 
> http://www.paul.sladen.org/thinkpad-r31/accelerometer.html
> http://www.paul.sladen.org/thinkpad-r31/aps/
> 
> Eric (who is looking forward playing Neverball the Right Way (tm) ;-) )
> 
> 
> PS: I don't know Paul Sladen's address and couldn't find it on his 
> webpage. Hopping this email address will do it anyway.
> 

Yup, it's just doing port IO.  Get a kernel debugger for windows like
softice and this will be trivial to RE.

READ_PORT_USHORT
WRITE_PORT_UCHAR
READ_PORT_UCHAR

Lee

