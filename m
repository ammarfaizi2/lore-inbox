Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSIALth>; Sun, 1 Sep 2002 07:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSIALth>; Sun, 1 Sep 2002 07:49:37 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:36343
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316728AbSIALtg>; Sun, 1 Sep 2002 07:49:36 -0400
Subject: Re: Vega Buddy B-210A
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208312219180.26157-100000@linux>
References: <Pine.LNX.4.44.0208312219180.26157-100000@linux>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 01 Sep 2002 12:53:57 +0100
Message-Id: <1030881237.3490.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-01 at 04:27, Brent D. Norris wrote:
> Running Redhat 7.3 I can get the OS to detect the Video Adapter that is
> built in to the card, but the rest of the stuff doesn't seem to get
> detected.  Is this possible with linux and if so is there some option that
> needs to be added to the kernel to get it to work?  I understand if it
> isn't, I mean this is kinda a random piece of equipment, but I was sure I
> had read about something like this being used, though I cannot seem to
> find the article via google.

Does an lspci show any function on the board claiming to be keyboard
and/or mouse. If so then we have most of the needed logic to get it
working as an extender. Two users/box is a bit trickier as the 2.2/2.4
console layer thinks only in terms of "one user, with keyboards and
monitors". Its possible to hack X a bit to sort of cover that up.

Alan

