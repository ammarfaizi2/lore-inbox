Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266846AbSKHRgk>; Fri, 8 Nov 2002 12:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266845AbSKHRgC>; Fri, 8 Nov 2002 12:36:02 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:42396 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266843AbSKHRgA>; Fri, 8 Nov 2002 12:36:00 -0500
Subject: Re: [Evms-announce] EVMS announcement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DC9909A.6040905@zytor.com>
References: <02110516191004.07074@boiler>	<20021106001607.GJ27832@marowsky-bree.de>	<103
	 6590957.9803.24.camel@irongate.swansea.linux.org.uk>
	<aqbv2d$tvd$1@cesium.transmeta.com>
	<1036617718.9781.73.camel@irongate.swansea.linux.org.uk> 
	<3DC9909A.6040905@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 18:06:10 +0000
Message-Id: <1036778770.16651.70.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 21:58, H. Peter Anvin wrote:
> > ataraid is just driving dumb ide controllers in the way bios raid does
> I guess I meant it as a more general question than those specific devices.

Our current software MD driver doesn't support doing that in hardware.
It has the neccessary infrastructure to consider using hardware xor
engines but I doubt its every actually more efficient to do so on low
end devices. 

