Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130066AbRBTLd4>; Tue, 20 Feb 2001 06:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130020AbRBTLdr>; Tue, 20 Feb 2001 06:33:47 -0500
Received: from [208.179.59.198] ([208.179.59.198]:23148 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129997AbRBTLdl>; Tue, 20 Feb 2001 06:33:41 -0500
Message-ID: <3A92560D.2040304@blue-labs.org>
Date: Tue, 20 Feb 2001 03:33:33 -0800
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac10 i686; en-US; 0.8) Gecko/20010216
X-Accept-Language: en
MIME-Version: 1.0
To: He-Who-Is-Not-Subscribed-to-LKML <acapnotic@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.1] system goes glacial, Reiser on /usr doesn't sync
In-Reply-To: <20010220021609.B11523@troglodyte.menefee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Turner wrote:

> Version:
> Linux version 2.4.1-pre12 (gcc version 2.95.3 20010125 (prerelease))
> 
> Possible suspect players: 
>   dpkg seems to trigger the bug
>   ReiserFS is the partition that doesn't sync
>   binfmt_misc shows up in the call traces.
> 
> Symptoms:
> 
> The system assumes glacial speeds.  If you're *lucky*, you'll see one
> widget re-paint in X before the next ice age.  Ctrl-alt-delete is
> unresponsive, as are attempts to start proccesses via the network or
> joystick port.  Keypresses to programs such as getty are not echoed.
> All program output to console and network is stopped dead.  If you leave
> for a several-hour-long coffee break and come back to it, there's still
> no evidence that you banged on the keyboard.


Wild shot in the dark....I'd lay odds that you had about 6-7 Megs free 
in your buffers/cache line, yes?

-d

