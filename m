Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270947AbRHTAFT>; Sun, 19 Aug 2001 20:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270948AbRHTAFJ>; Sun, 19 Aug 2001 20:05:09 -0400
Received: from ch-12-44-139-249.lcisp.com ([12.44.139.249]:27008 "HELO
	dual.lcisp.com") by vger.kernel.org with SMTP id <S270947AbRHTAE7>;
	Sun, 19 Aug 2001 20:04:59 -0400
From: "Kevin Krieser" <kkrieser_list@footballmail.com>
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: RE: Swap size for a machine with 2GB of memory
Date: Sun, 19 Aug 2001 19:05:08 -0500
Message-ID: <NDBBLFLJADKDMBPPNBALEEKBFCAA.kkrieser_list@footballmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <m11ym7ojvw.fsf@frodo.biederman.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just experimenting on my personal Linux computer this weekend, which
has 512MB of RAM and 700MB of swap.  I also have an unpatched 2.4.8 kernel
installed.

I wrote a program that allocated 700MB of RAM and touched every page, then
read it back in.  When finished, there remained 250+ meg of swap in use, but
no corresponding free space in RAM, compared to before running my test
program.  The expected behavior of the 2.4 kernels seemed to be followed,
where many programs retained space in both RAM and swap.

However, since my normal behavior is for swap to not be used, I will wait a
little bit for some of the VM updates to be tested.

I don't have 2X RAM because when I installed my system, I only had 256MB of
RAM.



