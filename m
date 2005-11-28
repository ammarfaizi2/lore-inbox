Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbVK1VIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVK1VIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVK1VIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:08:42 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:34894 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751311AbVK1VId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:08:33 -0500
Message-ID: <438B726D.9090405@tmr.com>
Date: Mon, 28 Nov 2005 16:11:09 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Patrick McFarland <diablod3@gmail.com>, gcoady@gmail.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: umount
References: <200511272154.jARLsBb11446@apps.cwi.nl> <jdkko1hs90ffvqru9v354vrubggcdrnhhj@4ax.com> <5bdc1c8b0511271742y75306962h67193b8a0191841d@mail.gmail.com> <200511272101.07771.diablod3@gmail.com> <20051128071535.GB3638@voodoo> <5bdc1c8b0511280920i424cb9e7t50399b4f12abc154@mail.gmail.com> <Pine.LNX.4.61.0511281229560.8176@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511281229560.8176@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Mon, 28 Nov 2005, Mark Knecht wrote:
> 
> 
>>On 11/27/05, Jim Crilly <jim@why.dont.jablowme.net> wrote:
>>
>>>On 11/27/05 09:01:07PM -0500, Patrick McFarland wrote:
>>>
>>>>On Sunday 27 November 2005 20:42, Mark Knecht wrote:
>>>>
>>>>>On 11/27/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
>>>>>
>>>>>>It leaves me with a little distrust of linux' handling of non-locked
>>>>>>removable media (as opposed to lockable media like a zipdisk or cdrom).
>>>>>>
>>>>>>Grant.
>>>>>
>>>>>Under Windows, if a 1394 drive is unplugged without unmounting, it you
>>>>>get a pop up dialog on screen telling you that data may be lost, etc.
>>>>>while under any of the main environments I've tried under Linux
>>>>>(Gnome, KDE, fluxbox) there are no such messages to the user. I have
>>>>>not investigated log files very deeply, other than to say that dmesg
>>>>>will show the drive going away but doesn't say it was a problem.
>>>>>
>>>>>I realize it's probably 100x more difficult to do this under Linux, at
>>>>>least at the gui level, but I agree with your main point that my trust
>>>>>factor is just a bit lower here.
>>>>
>>>>No, WIndows says that because it is unable to mount a partition as sync,
>>>>unlike Linux. Linux Desktop Environments simply don't tell the user because
>>>>no data is lost if they unplug the media.
>>>
>>>Both of those statements are not true.
>>
>>Jim,
>>  I'm not clear if 'both statements' included any of mine or not? :-)
>>
>>  You discussed the event I was thinking of. I am writing to a 1394
>>drive, bus powered or not, and while the write is occuring I unplug
>>the cable. Clearly the data being written is not going to finish, and
>>that's expected, but the 'reduced confidence' issue is that I'm not
>>told directly of the event. Granted I'll eventually discover it in
>>some indrect manner, like a GUI action failing or something timing
>>out. However in Windows I do appreciate the clear message that this
>>has happened.
>>
>>Thanks,
>>Mark
>>
> 
> 
> Doesn't your GUI show a 'console' window? I don't use the GUI,
> but the last time I checked, there was a 'console' window that
> showed the error messages. This was standard with Sun.
> 
> If you can find the 'console' window in your distribution, activate
> it. If it doesn't have one, contact your vendor or make one. There
> needs to be some visible evidence that something is going wrong.

xterm -C


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
