Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280600AbRKFViZ>; Tue, 6 Nov 2001 16:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280599AbRKFViG>; Tue, 6 Nov 2001 16:38:06 -0500
Received: from pc4-camb6-0-cust116.cam.cable.ntl.com ([213.104.14.116]:59126
	"EHLO kc.cam.armlinux.org") by vger.kernel.org with ESMTP
	id <S280587AbRKFVh5>; Tue, 6 Nov 2001 16:37:57 -0500
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Tim Schmielau <tim@physik3.uni-rostock.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lp.c, eexpress.c jiffies cleanup 
In-Reply-To: Message from Andreas Dilger <adilger@turbolabs.com> 
   of "Tue, 06 Nov 2001 14:15:21 MST." <20011106141521.R3957@lynx.no> 
In-Reply-To: <Pine.LNX.4.30.0111062039440.23693-100000@gans.physik3.uni-rostock.de>  <20011106141521.R3957@lynx.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Nov 2001 21:37:50 +0000
From: Philip Blundell <philb@gnu.org>
Message-Id: <E161Duo-0000jO-00@kc.cam.armlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20011106141521.R3957@lynx.no>, Andreas Dilger writes:
>On Nov 06, 2001  21:04 +0100, Tim Schmielau wrote:
>> In eexpress.c I also turned absolute jiffies number into multiples of HZ,
>> yet the resulting timeout values still do not always seem reasonable to
>> me.
>
>I agree.  It seems very ugly.  I looked at a few drivers which loop 1 or 2
>jiffies, but to busy-loop for 1/10th of a second, or even 20 seconds
>is terribly bad. 

Those timeouts are only a last resort.  If the card is working properly the loop will terminate much sooner.

p.

