Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269327AbUHZS6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269327AbUHZS6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269325AbUHZS6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:58:03 -0400
Received: from kendy.up.ac.za ([137.215.101.101]:39253 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S269327AbUHZS3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:29:21 -0400
Message-ID: <37473.165.165.45.152.1093544948.squirrel@165.165.45.152>
In-Reply-To: <20040820114531.GA11463@gamma.logic.tuwien.ac.at>
References: <20040809185018.GA26084@gamma.logic.tuwien.ac.at>
    <20040812204756.GA12117@gamma.logic.tuwien.ac.at>
    <20040820114531.GA11463@gamma.logic.tuwien.ac.at>
Date: Thu, 26 Aug 2004 20:29:08 +0200 (SAST)
Subject: Re: Consistent complete lock up with 2.6.8.1-mm2 and vuescan,
      no serial console output
From: "Jaco Kroon" <jkroon@cs.up.ac.za>
To: "Norbert Preining" <preining@logic.at>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       edhamrick@aol.com
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-Scan-Signature: 55848b4c92e14f55370843990e6edc02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining said:
> Hi Andrew, hi Ed, hi list!
> Anyway it would be nice to hear at least a comment from one of you on
> how to proceed with this. Since it is 100% repeatable here, it would be
> nice if it can be fixed. It suprises me that the whole kernel just
> completely freezes, while only disk io and cpu is used, there is no
> usage of usb stuff (besides the usb serial console, but also wihtout

I've got a similar problem on an old pentium 90 machine.  When compiling
glibc it'll run for about a day and then die with absolutely nothing in
the logs.  I've got a serial cable and another machine, so if someone can
point me at documentation on how to set it up I'd be willing to collect
whatever information I can over the weekend.

Jaco

>
> On Don, 12 Aug 2004, preining wrote:
>> The problem persisted with 2.6.8-rc4-mm1, always (repeatable 100%) after
>> around 30 scans the computer freezes completely. Not even sysrq works.
>>
>> But at least what I could check was that it is not a memory problem,
>> there is still enough swap free (close to 1G).
>>
>> So what can I do, any ideas?
>>
>> On Mon, 09 Aug 2004, preining wrote:
>> > I have a bit of a problem here: I am scanning with vuescan (latest
>> > version) on linux-2.6.8-rc3-mm1 a lot of images from raw files, i.e.
>> > only data io from the hard disk, no usb etc interferes, and always
>> after
>> > 20/30 something images the computer freezes completely. Not even Sysrq
>> > works. Only reset button. Of course, the syslog shows up nothing.
>> >
>> > Is there anything you two can think of what could be the reason?
>> >
>> > (and no, I have no chance to use serial console, but I doubt it would
>> be
>> > useful)


