Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSHITv5>; Fri, 9 Aug 2002 15:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSHITv5>; Fri, 9 Aug 2002 15:51:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63236 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315634AbSHITv4>; Fri, 9 Aug 2002 15:51:56 -0400
Message-ID: <3D541E2C.3010000@zytor.com>
Date: Fri, 09 Aug 2002 12:55:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org
Subject: Re: klibc development release
References: <aivdi8$r2i$1@cesium.transmeta.com>	<200208090934.g799YVZe116824@d12relay01.de.ibm.com>	<200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com>	<3D541018.4050004@zytor.com> <15700.4689.876752.886309@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>>>>>>On Fri, 09 Aug 2002 11:55:20 -0700, "H. Peter Anvin" <hpa@zytor.com> said:
>>>>>
> 
>   HPA> Hmf... some of these seem to be outright omissions
>   HPA> (pivot_root() and umount2() especially), and probably indicate
>   HPA> bugs or that the stock kernel isn't up to date anymore.
> 
>   HPA> I can see umount() being missing (as in "use umount2()").
> 
> Alpha calls umount2() "oldumount"; ia64 never had a one-argument
> version of umount(), so there is no point creating legacy (and the
> naming is inconsistent anyhow...).
> 

You mean alpha calls umount2() "umount" and umount() "oldumount"?

	-hpa


