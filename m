Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293504AbSCERFx>; Tue, 5 Mar 2002 12:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293508AbSCERFl>; Tue, 5 Mar 2002 12:05:41 -0500
Received: from razor.hemmet.chalmers.se ([193.11.251.99]:30340 "EHLO
	razor.hemmet.chalmers.se") by vger.kernel.org with ESMTP
	id <S293504AbSCERFZ>; Tue, 5 Mar 2002 12:05:25 -0500
Message-ID: <3C84FAB4.7020702@kjellander.com>
Date: Tue, 05 Mar 2002 18:04:52 +0100
From: Carl-Johan Kjellander <carljohan@kjellander.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
In-Reply-To: <3C8419FF.10103@kjellander.com> <20020305051146.GA7075@kroah.com> <200203051612.g25GCtc23752@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Dienstag, 5. März 2002 06:11 schrieb Greg KH:
> 
>>On Tue, Mar 05, 2002 at 02:06:07AM +0100, Carl-Johan Kjellander wrote:
>>
>>>Attached to each one of these is an Philips ToUCam pro which uses the pwc
>>>and pwcx modules. (yes, the kernel becomes tainted by the pwcx module)
>>>
>>As you are using this closed source module, I suggest you take this up
>>with that module's author.
>>
> 
> Perhaps you could first ask whether the hang can be reproduced
> without that module loaded ?
> Secondly, that module is unlikely to cause that kind of trouble.

The problem can be reproduced on a computer that has not loaded pwcx.o
after boot. The problem is not caused by pwcx.o at all.


/Carl-Johan Kjellander
-- 
begin 644 carljohan_at_kjellander_dot_com.gif
Y1TE&.#=A(0`F`(```````/___RP`````(0`F```"@XR/!\N<#U.;+MI`<[U(>\!UGQ9BGT%>'D2I
Y*=NX,2@OUF2&<827ILW;^822C>\7!!Z1,!K'B5(6H<SH-"E*TJ3%*/>QI6:7"A>Y?):D2^*U@NCV
R<MOQ=]V(B6>LZYD-_T1U<@3W]A4(^$-W4]A#V")W6#.R"$;IR'@).46BN7$9>5D``#L`

