Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWCMIaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWCMIaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 03:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWCMIaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 03:30:20 -0500
Received: from nef2.ens.fr ([129.199.96.40]:61193 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932361AbWCMIaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 03:30:20 -0500
Date: Mon, 13 Mar 2006 09:30:34 +0100
From: Eric.Brunet@lps.ens.fr
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Patrick Mau <mau@oscar.ping.de>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problem with a CD
Message-ID: <20060313083034.GA27010@platane.lps.ens.fr>
References: <20060312162825.GA16993@platane.lps.ens.fr> <20060312181548.GA14889@oscar.prima.de> <Pine.LNX.4.61.0603122152350.3155@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0603122152350.3155@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Mon, 13 Mar 2006 09:30:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 09:53:30PM +0100, Jan Engelhardt wrote:
> >
> >Since this is a video cd, the files associated with the stream cannot
> >be accessed by mounting the medium.
> 
> It's because the video data is outside the iso9660 fs, is not it?
> 
> >The filesystem of VCD is not a
> >normal filesystem, so you have to rip the video stream by using a tool
> >like vcdxrip.

Ah, ok. Sorry for the noise. I had never seen a VCD before. I just tried
to do
	xine vcd:// 
one one of the computers and it worked perfectly.

However, under windows, what I did was simply to open the disc in the
explorer, look at the files, right-click on the largest file to open it
with windows media player, or drag and drop it to copy it on the hard
drive, without any special tool.

I find it a bit deceptive that linux lets me mount the filesystem but not
access the files. It would be actually better, I feel, if mount
would refuse to work on a vcd and display some informative failure
message rather than mount an unreadable filesystem...

Thanks,

	Éric

