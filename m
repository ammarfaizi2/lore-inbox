Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312975AbSDBWZk>; Tue, 2 Apr 2002 17:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312977AbSDBWZb>; Tue, 2 Apr 2002 17:25:31 -0500
Received: from [24.93.67.52] ([24.93.67.52]:56850 "EHLO mail5.mgfairfax.rr.com")
	by vger.kernel.org with ESMTP id <S312975AbSDBWZU>;
	Tue, 2 Apr 2002 17:25:20 -0500
Message-ID: <3CAA05A9.9080706@cox.rr.com>
Date: Tue, 02 Apr 2002 14:25:29 -0500
From: Louis Adamich <ladamich@cox.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020118
X-Accept-Language: en-us
MIME-Version: 1.0
To: Bob Miller <rem@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 keyboard problem
In-Reply-To: <3CA99976.8060505@cox.rr.com> <20020402073920.A26631@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw that already,

Here is a snippet from my .config

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_I8042_REG_BASE=60
CONFIG_I8042_KBD_IRQ=1
CONFIG_I8042_AUX_IRQ=12
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_PS2SERKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set




>On Tue, Apr 02, 2002 at 06:43:50AM -0500, Louis Adamich wrote:
>
>>I'm having a problem getting my keyboard to work on 2.5.7.  2.5.5 
>>compiled and works correctly for me.  2.5.7 compiles with no errors as 
>>well as all modules compiling with no errors.  No matter what 
>>combination of config params I try I can't get the system to recognize 
>>keystrokes.  If I boot to level 3 I just see nothing when I type.  If I 
>>boot into X I can move the mouse around until I press a key and then the 
>>mouse freezes.  The machine is still running as I can telnet into it 
>>from another machine.  I also tried downloading and applying the dj 
>>patch.  Same symptoms.
>>
>>Machine is an Althon XP 1800+, soyo dragon plus motherboard, ATI 128 
>>video card, 40 gig ide hard drive.
>>
>>What info do I need to post to get some help debugging this thing?
>>
>>Thanks,
>>
>>Louis Adamich
>>
>
>Look at:
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=101751890301820&w=2
>
>This should get you pointed in the right direction.
>



