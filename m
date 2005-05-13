Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVEMV3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVEMV3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVEMV0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:26:36 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:9675 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261527AbVEMVZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:25:49 -0400
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Bill Davidsen <davidsen@tmr.com>, linux-os@analogic.com,
       "Srinivas G." <srinivasg@esntechnologies.co.in>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200505132047.j4DKlcgV025923@turing-police.cc.vt.edu>
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in>
	 <200505131522.32403.vda@ilport.com.ua>
	 <Pine.LNX.4.61.0505130825310.4428@chaos.analogic.com>
	 <Pine.LNX.4.61.0505130837390.4781@chaos.analogic.com>
	 <42850FC7.7010603@tmr.com>
	 <200505132047.j4DKlcgV025923@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116019438.26693.501.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 May 2005 22:24:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-05-13 at 21:47, Valdis.Kletnieks@vt.edu wrote:
> The heck with leap seconds - why did it warp back to 1901 rather
> than to 1969/1970? ;)

time_t is signed so it jumps back. 0:00 UTC is 0 not -MAXINT.

