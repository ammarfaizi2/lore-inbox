Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRKICyf>; Thu, 8 Nov 2001 21:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276877AbRKICyQ>; Thu, 8 Nov 2001 21:54:16 -0500
Received: from vp226158.uac62.hknet.com ([202.71.226.158]:42508 "EHLO
	main.coppice.org") by vger.kernel.org with ESMTP id <S275743AbRKICyM>;
	Thu, 8 Nov 2001 21:54:12 -0500
Message-ID: <3BEB4630.6010103@coppice.org>
Date: Fri, 09 Nov 2001 10:57:52 +0800
From: Steve Underwood <steveu@coppice.org>
Organization: Me? Organised?
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en, zh-TW
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linux Kermel ML <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686 timer bugfix incomplete
In-Reply-To: <E161RcS-0003x8-00@the-village.bc.nu> <3BE98BA9.7090102@coppice.org> <20011108211126.B6266@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Vojtech Pavlik wrote:

> On Thu, Nov 08, 2001 at 03:29:45AM +0800, Steve Underwood wrote:
>>If the messages:
>>
>>probable hardware bug: clock timer configuration lost - probably a 
>>VIA686a motherboard.
>>probable hardware bug: restoring chip configuration.
>>
>>are really related to a VIA686A bug, why do they erratically appear on 
>>Compaq ML370's, which use ServerWorks chip sets? Is there a common bug 
>>between these chip sets? Seems unlikely.
>>
> 
> Just to make sure: Is on the system the Ftape of any joystick driver in
> use? If not, then:
> 
> The ServerWorks chip set has a bug that is shared with old Intel Neptune
> chipset most likely. This is a problem per se, but also triggers the VIA
> bug workaround. The VIA bug test can be enhanced to detect this false
> alarm, but the Neptune-like bug still stays and is dangerous as well.
> 
> At least the VIA workaround told us something fishy is happening on
> non-VIA hardware as well.
> 
> For example on my VIA686a/cg (late revision), the workaround is never
> triggered.


There are no such devices in use in our machines. This is happening on 3

Compaq servers, and each has a similar configuration. A Compaq ML370,

1G RAM, a Compaq Smart Array 431 RAID controller, and some Dialogic

telephony cards.


I don't have one of these machines running without telephony cards, to 
see if that has any significance.The only external interfaces we use are 
the LAN, one of the serial ports, and the phone lines connected to the 
Dialogic cards. The SCSI controller is idle, as the disks are on the 
RAID controller. The IDE interface has a CD-ROM on it..

 From what you say, it sounds like the ServerWorks chipset may well have 
a timer bug. This machine uses the LE 3.0 chipset.

Regards,
Steve



