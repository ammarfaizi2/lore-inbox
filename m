Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBHAhQ>; Wed, 7 Feb 2001 19:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbRBHAhG>; Wed, 7 Feb 2001 19:37:06 -0500
Received: from mercury.nildram.co.uk ([195.112.4.37]:17938 "EHLO
	mercury.nildram.co.uk") by vger.kernel.org with ESMTP
	id <S129026AbRBHAgy>; Wed, 7 Feb 2001 19:36:54 -0500
Message-ID: <3A81E707.1060705@magenta-netlogic.com>
Date: Thu, 08 Feb 2001 00:23:35 +0000
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; m18) Gecko/20010126
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: linux-kernel@vger.kernel.org,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: ACPI slowdown...
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE666@orsmsx35.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:

> Since you have a symtomatic system, if you're willing to do some testing to
> either prove or disprove your theory (that entering C2/C3 interrupts enabled
> helps things) I would greatly appreciate it.

Leaving interrupts enabled does help a little, but the machine is still 
unusably slow, so it's not the fix.

 
> Also, the next ACPI update will let you disable using this code for idle (so
> we have some breathing room while we fix it) and will print some more C
> state info on boot, because although you don't say, it sounds like you have
> a desktop system, which usually don't support C2/C3, and so should not be
> trying to enter them.

Disabling the idle code definitely fixes it.

Tony


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
