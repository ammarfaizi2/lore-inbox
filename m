Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268865AbRHFQns>; Mon, 6 Aug 2001 12:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268864AbRHFQni>; Mon, 6 Aug 2001 12:43:38 -0400
Received: from www.transvirtual.com ([206.14.214.140]:54286 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S268865AbRHFQn1>; Mon, 6 Aug 2001 12:43:27 -0400
Date: Mon, 6 Aug 2001 09:43:11 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: =?iso-8859-1?Q?S=F6nke?= Ruempler <ruempler@topconcepts.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: mdacon
In-Reply-To: <3B6EC51F.1A1200CC@topconcepts.com>
Message-ID: <Pine.LNX.4.10.10108060939500.2898-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> two questions fpr the mdacon driver:
> 
> 1) Can I use 2 mdacon cards with the mdacon driver ?

No. MDA uses a fixed standard register location to program its hardware.
The two cards would conflict. Unless your MDA cards are pci based or they
can change their register location your out of luck. Sorry. You can run
MDA along side VGA. I do it all the time at home.

> 2) mdacon doesnt work in 2.4 - if i echo something to /dev/tty14 -
> system halts.

Strange. My system works fine here. I assume you have vgacon as well. What
do you see printed out on the VGA monitor when you insmod the driver?

