Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289311AbSA1SYU>; Mon, 28 Jan 2002 13:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289312AbSA1SYL>; Mon, 28 Jan 2002 13:24:11 -0500
Received: from brick.homesquared.com ([216.177.65.65]:16791 "EHLO
	brick.homesquared.com") by vger.kernel.org with ESMTP
	id <S289311AbSA1SXv>; Mon, 28 Jan 2002 13:23:51 -0500
Message-ID: <3C5596E1.1030905@coplanar.net>
Date: Mon, 28 Jan 2002 10:22:25 -0800
From: Jeremy Jackson <jerj@coplanar.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
CC: Ed Sweetman <ed.sweetman@wmich.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        preining@logic.at, ttonino@users.sourceforge.net,
        moffe@amagerkollegiet.dk, timothy.covell@ashavan.org,
        Dieter.Nuetzel@hamburg.de, nitrax@giron.wox.org, mpet@bigfoot.de,
        lkml@sigkill.net, pavel@suse.cz, vandrove@vc.cvut.cz, hpj@urpla.net,
        whitney@math.berkeley.edu
Subject: Re: acpi-rouble/amd disconnect patch
In-Reply-To: <Pine.LNX.4.40.0201281211520.21970-100000@hades.uni-trier.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Nofftz wrote:

>On 25 Jan 2002, Ed Sweetman wrote:
>
>>It sounds like you'll have to make the patch work just for Athlon XP's
>>...  unless of course you're not expecting it to be included in the
>>kernel ever.
>>
>
>hmmm ...
>i am not quite shure that this is only working with an xp processor ... at
>the moment i'm looking for some additional informations, how to tune the
>processor registers to implement the fix for the errata 11 bug. it must be
>possible from within the kernel to do this. you have to modify the
>CLK_CTRL MSR to a different value. i hope amd will send me the document
>#24478 where the right values are described ...
>has someone experiences how to modify msr ? i found 2 assambler commands
>("rdmsr/wtmsr") but i have no experiences with assamambler ...
>
If you configure the MSR support in when compiling the kernel, you get 
/dev/cpu/0/msr
which you can use to read/write them.

I don't see that doc on their website, and others have failed to find it 
as well.  It's probably NDA, so ask your motherboard/BIOS MFR for an 
update...

>
>
>daniel
>
>
>
># Daniel Nofftz
># Sysadmin CIP-Pool Informatik
># University of Trier(Germany), Room V 103
># Mail: daniel@nofftz.de
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



