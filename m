Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSJURqv>; Mon, 21 Oct 2002 13:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJURqu>; Mon, 21 Oct 2002 13:46:50 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:30133 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261474AbSJURqs>; Mon, 21 Oct 2002 13:46:48 -0400
Subject: Re: [PATCH] compile fix for dmi_scan.c in 2.4.bk-current
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0210211404570.11201-100000@freak.distro.conectiva>
References: <Pine.LNX.4.44L.0210211404570.11201-100000@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 19:07:36 +0100
Message-Id: <1035223656.27259.230.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 17:07, Marcelo Tosatti wrote:
> > Lose the problem function and the HP specific quirk and you'll get the
> > bits that actually do matter
> 
> I merged the HP Pavilion quirks on my tree and then backed it all out
> later because I thought the changes were not necessary for 2.4.20.
> 
> Which issues the DMI update is addressing?

The stuff I sent you included a pile of correctness fixes for the DMI
code that are in dmidecode and came from the lm-sensors folk

