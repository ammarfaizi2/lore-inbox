Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTDOIIG (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 04:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbTDOIIG (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 04:08:06 -0400
Received: from ns.tasking.nl ([195.193.207.2]:57608 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S264393AbTDOIIF (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 04:08:05 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67 Oops in usb_dump_interface after rmmod ov511
Organization: Altium SOFTWARE B.V.
References: <16025.44377.247003.44494@iris.hendrikweg.doorn> <16025.44377.247003.44494@iris.hendrikweg.doorn> <20030415055226.GB8859@kroah.com>
X-Face: "A(HPX!owGRCdtOX\NKs=ac*&x%/sYJMc;M<L&"^kH9ogp5;"w#UVc0yt3K{@n#.E+=k>qd bqZYYQvB9_xdS1l+B2\z;:p71RNxrja;ir>Dj?6%GzFA!o>gOL&G}8X;icnhqP|=TU,O@JVM%5LL:X ,G&IkRk9n%h7hZFUltu%RB=ctrdfu?[vSRV%Wzcn;#o>[K0C6_'q*~^+toc))w-Qb8*,afMHVCrNG6
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: kees.bakker@altium.nl (Kees Bakker)
Date: 15 Apr 2003 10:18:43 +0200
Message-ID: <si7k9w897g.fsf@koli.tasking.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.96
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Greg KH writes:
> 
> On Sun, Apr 13, 2003 at 08:32:57PM +0200, Kees Bakker wrote:
>> If I do a "cat /proc/bus/usb/devices" after removing the ov511 module I get
>> an OOPS.
>> Here is the info from my syslog:
> 
> Ouch, not good.
> 
> Does this happen for any other USB devices?

Who knows. I don't have another USB device to try. Perhaps I could lend one.

> And can you add a bug to bugzilla.kernel.org for this, so I remember to
> make sure it's fixed?  :)

Done. (http://bugzilla.kernel.org/show_bug.cgi?id=585)

		Kees

