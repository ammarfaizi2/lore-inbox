Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313019AbSDOTYW>; Mon, 15 Apr 2002 15:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313041AbSDOTYV>; Mon, 15 Apr 2002 15:24:21 -0400
Received: from cliff.mcs.anl.gov ([140.221.9.17]:57217 "EHLO mcs.anl.gov")
	by vger.kernel.org with ESMTP id <S313019AbSDOTYV>;
	Mon, 15 Apr 2002 15:24:21 -0400
To: tomas szepe <kala@pinerecords.com>
Cc: James Simmons <jsimmons@transvirtual.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 keyboard problem
In-Reply-To: <Pine.LNX.4.44.0204152105220.27809-100000@louise.pinerecords.com>
From: "Narayan Desai" <desai@mcs.anl.gov>
Date: Mon, 15 Apr 2002 14:24:06 -0500
Message-ID: <yrxg01wlq95.fsf@catbert.mcs.anl.gov>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.1 (Cuyahoga Valley,
 i386-mandrake-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am experiencing a similar problem, though my keyboard works, but no
mouse is detected. I have built a 2.5.7-dj4 kernel with the supplied
config on an IBM thinkpad 600E (ps2 mouse, etc)
 -nld

>>>>> "tomas" == tomas szepe <kala@pinerecords.com> writes:

>> > an excerpt from the 2.5.8 .config in question: .  .
>> > CONFIG_INPUT=y CONFIG_INPUT_KEYBDEV=y CONFIG_INPUT_MOUSEDEV=y .
>> > .  CONFIG_SERIO=y CONFIG_SERIO_SERPORT=y
>>
>> Wrong config for DJ tree. Here is what you need for PS/2 input
>> keyboard support.
>>
>> CONFIG_SERIO=y CONFIG_SERIO_I8042=y CONFIG_I8042_REG_BASE=60
>> CONFIG_I8042_KBD_IRQ=1 CONFIG_I8042_AUX_IRQ=12
>>
>> Also don't forget
>>
>> CONFIG_INPUT_KEYBOARD=y CONFIG_KEYBOARD_ATKBD=y
>>
>> CONFIG_INPUT_MOUSE=y CONFIG_MOUSE_PS2=y


tomas> Yes, I'm aware, maybe I should have included the -dj .config as
tomas> well.  Same results I'm afraid.

tomas> T.

tomas> - To unsubscribe from this list: send the line "unsubscribe
tomas> linux-kernel" in the body of a message to
tomas> majordomo@vger.kernel.org More majordomo info at
tomas> http://vger.kernel.org/majordomo-info.html Please read the FAQ
tomas> at http://www.tux.org/lkml/

