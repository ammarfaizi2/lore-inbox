Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbTCEPhr>; Wed, 5 Mar 2003 10:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbTCEPhr>; Wed, 5 Mar 2003 10:37:47 -0500
Received: from terminus.zytor.com ([63.209.29.3]:57804 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S267300AbTCEPhb>; Wed, 5 Mar 2003 10:37:31 -0500
Message-ID: <3E661C1D.904@zytor.com>
Date: Wed, 05 Mar 2003 07:47:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@user.it.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to boot a raw kernel image :??
References: <20021129132126.GA102@DervishD>	<3DF08DD0.BA70DA62@gmx.de>	<b453er$qo7$1@cesium.transmeta.com> <15974.6329.574794.597753@gargle.gargle.HOWL>
In-Reply-To: <15974.6329.574794.597753@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> FWIW, I still use bzdisk images frequently, and the 1MB limit really
> is a serious problem for 2.5 kernels, and 2.4 kernels build with gcc-3.
> I'm currently using a patched kernel where `make bzdisk' invokes a
> user-specified script, which in my case goes roughly like:
> 

If you get my nobootsect patch:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/nobootsect-2.5.63-bk7-1.diff

... you will find something similar, but a bit more fleshed out.

This is the patch I'm trying to get Linus to accept.

	-hpa


