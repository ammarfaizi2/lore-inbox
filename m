Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTILSos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTILSnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:43:18 -0400
Received: from fep02-svc.mail.telepac.pt ([194.65.5.201]:34696 "EHLO
	fep02-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S261861AbTILSl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:41:59 -0400
Message-ID: <3F6213AF.1010609@vgertech.com>
Date: Fri, 12 Sep 2003 19:42:55 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Misha Nasledov <misha@nasledov.com>
CC: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
Subject: Re: bttv bug
References: <20030910064158.GA19930@nasledov.com> <20030910074123.GH18280@vitelus.com> <3F5F99AD.6080502@vgertech.com> <20030912023814.GA5274@nasledov.com>
In-Reply-To: <20030912023814.GA5274@nasledov.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Misha Nasledov wrote:

[..snip..]

> 
> So am I pretty much on my own with this problem? Does anyone use a Bt878 card
> with an nvidia card under 2.6? It's strange that it used to work just fine,


I have these:
# lspci|grep Brook
00:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
00:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)

And this card (hauppagge wintv) works fine with 2.4 but doesn't work (at 
least for long...) in vanilla 2.6.0-test1 -> test3. I'll try a newer 
kernel shortly :-)

I also have a nvidia card but I don't have any nvidia drivers installed.

One more note: in my setup I must use "NoMTRR":

Section "Screen"
         Identifier      "Default Screen"
         Device          "nVidia Corporation [NV15]"
         Monitor         "Generic Monitor"

         Option          "NoMTRR"
... etc...

Or I'll get screen corruption sooner or later.


Good luck,
Nuno Silva

