Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264400AbTEHBuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 21:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbTEHBuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 21:50:13 -0400
Received: from 130.146.174.203.mel.ntt.net.au ([203.174.146.130]:34700 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP id S264400AbTEHBuM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 21:50:12 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPUFreq sysfs interface MIA?
In-Reply-To: <20030508003223.GA5051@kroah.com> (Greg KH's message of "Wed, 7
 May 2003 17:32:23 -0700")
References: <873cjsv8hg.fsf@enki.rimspace.net>
	<20030506211210.GA3148@kroah.com> <87n0hzbnk6.fsf@enki.rimspace.net>
	<20030507233257.GA4481@kroah.com> <873cjqmgl6.fsf@enki.rimspace.net>
	<20030508003223.GA5051@kroah.com>
From: Daniel Pittman <daniel@rimspace.net>
Date: Thu, 08 May 2003 12:02:43 +1000
Message-ID: <87r87akxfg.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Greg KH wrote:
> On Thu, May 08, 2003 at 10:23:33AM +1000, Daniel Pittman wrote:
>> On Wed, 7 May 2003, Greg KH wrote:
>> > On Wed, May 07, 2003 at 10:36:09AM +1000, Daniel Pittman wrote:
>> >> On Tue, 6 May 2003, Greg KH wrote:
>> >> > On Tue, May 06, 2003 at 05:29:15PM +1000, Daniel Pittman wrote:
>> >> >> 
>> >> >> The content of /sys/devices/sys/cpu0 is:
>> >> >> /sys/devices/sys/cpu0
>> >> >> |-- name
>> >> >> `-- power
>> >> > 
>> >> > What does /sys/class/cpu show?
>> >> 
>> >> /sys/class/cpu
>> >> `-- cpu0
>> >>     `-- device -> ../../../devices/sys/cpu0
>> > 
>> > Oops, forgot to hook up stuff... Does the following patch from
>> > Jonathan Corbet fix this?
>> 
>> I tested this patch earlier and, no, it does not resolve the issue.
>> I have exactly the same issue with it applied as before.
> 
> Hm, I just applied this patch, and dug up some hardware that will work
> with cpufreq, and it shows up just fine for me.  I don't know what's
> wrong, sorry.

Sorry, the cpufreq interface changed location and I didn't look closely
enough into it.  With the patch applied, the cpufreq support is
available and works correctly.

So, this was a fault on my part and the patch works. Sorry.

    Daniel

-- 
I have never seen a bad television program, because I refuse to.
God gave me a mind, and a wrist that turns things off.
        -- Jack Paar
