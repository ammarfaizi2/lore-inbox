Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBTQ0v>; Tue, 20 Feb 2001 11:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBTQ0l>; Tue, 20 Feb 2001 11:26:41 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:59147 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129107AbRBTQ0Y>; Tue, 20 Feb 2001 11:26:24 -0500
Date: Tue, 20 Feb 2001 11:25:59 -0500
From: Chris Mason <mason@suse.com>
To: David <david@blue-labs.org>,
        He-Who-Is-Not-Subscribed-to-LKML <acapnotic@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.1] system goes glacial, Reiser on /usr doesn't sync
Message-ID: <1772480000.982686359@tiny>
In-Reply-To: <3A92560D.2040304@blue-labs.org>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, February 20, 2001 03:33:33 AM -0800 David <david@blue-labs.org>
wrote:

> Kevin Turner wrote:
> 
>> Version:
>> Linux version 2.4.1-pre12 (gcc version 2.95.3 20010125 (prerelease))
>> 
>> Possible suspect players: 
>>   dpkg seems to trigger the bug
>>   ReiserFS is the partition that doesn't sync
>>   binfmt_misc shows up in the call traces.
>> 
>> Symptoms:
>> 
>> The system assumes glacial speeds.  If you're *lucky*, you'll see one
>> widget re-paint in X before the next ice age.  Ctrl-alt-delete is
>> unresponsive, as are attempts to start proccesses via the network or
>> joystick port.  Keypresses to programs such as getty are not echoed.
>> All program output to console and network is stopped dead.  If you leave
>> for a several-hour-long coffee break and come back to it, there's still
>> no evidence that you banged on the keyboard.
> 
> 
> Wild shot in the dark....I'd lay odds that you had about 6-7 Megs free in
> your buffers/cache line, yes?
> 

David, have any of Rik's patches helped here?

-chris

