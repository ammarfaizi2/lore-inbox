Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311577AbSCYB43>; Sun, 24 Mar 2002 20:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSCYB4T>; Sun, 24 Mar 2002 20:56:19 -0500
Received: from c17736.belrs2.nsw.optusnet.com.au ([211.28.31.90]:19114 "EHLO
	bozar") by vger.kernel.org with ESMTP id <S311532AbSCYB4N>;
	Sun, 24 Mar 2002 20:56:13 -0500
Date: Mon, 25 Mar 2002 12:55:38 +1100
From: Andre Pang <ozone@algorithm.com.au>
To: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Cc: linux-kernel@vger.kernel.org, Steven Walter <srwalter@yahoo.com>
Subject: Re: Screen corruption in 2.4.18
Mail-Followup-To: Danijel Schiavuzzi <dschiavu@public.srce.hr>,
	linux-kernel@vger.kernel.org, Steven Walter <srwalter@yahoo.com>
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <20020323160647.GA22958@hapablap.dyn.dhs.org> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au> <200203241507.g2OF7WN26069@ls401.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Message-Id: <1017021338.345762.13479.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 04:07:31PM +0100, Danijel Schiavuzzi wrote:

> > same screen corruption.  Clearing only bit 7 of register 55 fixes
> 
> Well, we're not the only ones with this problem. BTW, which motherboard do 
> you have? Maybe it's a mainboard failure (mine is a MSI MS-6340M V1). I know 
> one more Linux user with this problem on the same M/B.

I have an Asus A7VC.  They're the motherboards that come with the
cute little Asus Terminator K7s[1]; I have no idea if you can
actually get this motherboard if you don't buy that kit.  So it's
not a motherboard-specific problem.

Relevant output from lspci for the A7VC:

    00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 81)
    00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
    01:00.0 VGA compatible controller: S3 Inc. ProSavage KM133 (rev 03)

    00:00.0 Class 0600: 1106:0305 (rev 81)
    00:01.0 Class 0604: 1106:8305
    01:00.0 Class 0300: 5333:8a26 (rev 03)

1. http://www.asus.com.tw/desktop/terminator/overview.htm


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
