Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSKHTbC>; Fri, 8 Nov 2002 14:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbSKHTbC>; Fri, 8 Nov 2002 14:31:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48652 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262266AbSKHTbB>; Fri, 8 Nov 2002 14:31:01 -0500
Message-ID: <3DCC126F.6020507@zytor.com>
Date: Fri, 08 Nov 2002 11:37:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Evms-announce] EVMS announcement
References: <02110516191004.07074@boiler>	<20021106001607.GJ27832@marowsky-bree.de>	<103	 6590957.9803.24.camel@irongate.swansea.linux.org.uk>	<aqbv2d$tvd$1@cesium.transmeta.com>	<1036617718.9781.73.camel@irongate.swansea.linux.org.uk> 	<3DC9909A.6040905@zytor.com> <1036778770.16651.70.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, 2002-11-06 at 21:58, H. Peter Anvin wrote:
> 
>>>ataraid is just driving dumb ide controllers in the way bios raid does
>>
>>I guess I meant it as a more general question than those specific devices.
>
> Our current software MD driver doesn't support doing that in hardware.
> It has the neccessary infrastructure to consider using hardware xor
> engines but I doubt its every actually more efficient to do so on low
> end devices. 

Probably not.  The only case where I can imagine it helps is when you
get to push less data across the bus.

	-hpa

