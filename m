Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbRGPLXn>; Mon, 16 Jul 2001 07:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267290AbRGPLXe>; Mon, 16 Jul 2001 07:23:34 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:50954 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S267281AbRGPLXY>; Mon, 16 Jul 2001 07:23:24 -0400
Message-ID: <3B52CEAF.12281126@damncats.org>
Date: Mon, 16 Jul 2001 07:23:27 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
In-Reply-To: <E15Lnrk-00047x-00@the-village.bc.nu> <3B52438B.3CC6E1BC@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gareth Hughes wrote:
> 
> Alan Cox wrote:
> >
> > Right but we cannot go around breaking support for older setups. A user
> > updating their 2.4.x stable kernel and finding X11 no longer works simply isnt
> > an acceptable situation for serious users.
> 
> Agreed 100%.

Why not do something similar to the aic7xxx driver? Place the old DRM in
code in a pre-X4.1.0 subdirectory, with a warning that it will become
obsolete as of 2.5, and bring in the new code. When you build the
kernel, you can then choose which DRM version you want and everybody is
happy.

John
