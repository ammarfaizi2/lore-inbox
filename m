Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289823AbSBSUZP>; Tue, 19 Feb 2002 15:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289829AbSBSUZL>; Tue, 19 Feb 2002 15:25:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44556 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289817AbSBSUYD>; Tue, 19 Feb 2002 15:24:03 -0500
Message-ID: <3C72B452.20102@zytor.com>
Date: Tue, 19 Feb 2002 12:23:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Missed jiffies
In-Reply-To: <3C6E77DE.70FE49DF@rwii.com> <3C6E833F.1A888B3C@mvista.com> <a4pbvi@cesium.transmeta.com> <20020219093052.B37@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Hi!
> 
> 
>>>lap tops), is the fact that TSC is NOT clocked at a fixed rate.  It is
>>>affected by throttling (reduced in 12.5% increments) and by power
>>>management.
>>>
>>If the TSC is affected by HLT, throttling, or C2 power management, the
>>TSC is broken (as it is on Cyrix chips, for example.)  The TSC usually
>>*is* affected by C3 power management, but the OS should be aware of
>>C3.
>>
> 
> Add thinkpad 560X (pentium/MMX) and toshiba 4030cdt (celeron) to your
> blacklist, then. I believe that by your definition *many* sstems are
> broken.
> 								Pavel


It's sad but true.  Unfortunately the TSC seems to be considered a
low-priority operation.  It's for systems like the above you need the
"no-tsc" option.

	-hpa


