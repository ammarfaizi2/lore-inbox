Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271318AbUJVNIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271318AbUJVNIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271269AbUJVNHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:07:10 -0400
Received: from imap.gmx.net ([213.165.64.20]:47829 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271271AbUJVM7W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:59:22 -0400
X-Authenticated: #14776911
From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
Reply-To: stefandoesinger@gmx.at
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 22 Oct 2004 14:57:41 +0200
User-Agent: KMail/1.7
Cc: "Pavel Machek" <pavel@ucw.cz>,
       "Kendall Bennett" <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
References: <88056F38E9E48644A0F562A38C64FB6003287A2A@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6003287A2A@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200410221457.41542.stefandoesinger@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right now I am using call_usermodehelper() to call the
> emulator during resume and the video comes back just fine on this
> system where Ole's patch didn't work.
Can you explain me how you do this? call_usermodehelper() doesn't work for me 
at resume time.

BTW, I had a look at the radeon card's resume code at 0xc000:3 and attempted 
to implement it in a kernel module. The code is pretty simple, but it's quite 
long. My module isn't finished, it only turns off the display and resets the 
memory. I had to stop because I've a lot of things to do for school now.

Ole Rohne meant that the code is potentially dangerous because it pokes around 
with undocumented PLL registers, so I will not send it to the list: I will 
send it only to those who explicitly ask for it.

Stefan Dösinger
