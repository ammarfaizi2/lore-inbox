Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288595AbSANJL3>; Mon, 14 Jan 2002 04:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288731AbSANJLT>; Mon, 14 Jan 2002 04:11:19 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:15261 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S288595AbSANJLL>; Mon, 14 Jan 2002 04:11:11 -0500
Date: Mon, 14 Jan 2002 11:10:02 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Jim Studt <jim@federated.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts
In-Reply-To: <200201140029.g0E0TRD7026024@core.federated.com>
Message-ID: <Pine.LNX.4.33.0201141107230.28735-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002, Jim Studt wrote:

> I have six of these machines and am holding one out as a spare.  I will
> be happy to continue testing and prodding on that spare unit.
>
> For reference I now have...
>
> # cat /proc/interrupts    (eth2 is the afflicted card on the second PCI bus)
>            CPU0
>   0:      32594          XT-PIC  timer
>   1:          2          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   5:       1316          XT-PIC  eth2
>   7:        892          XT-PIC  aic7xxx
>  11:       2132          XT-PIC  eth0
>  15:          4          XT-PIC  ide1
> NMI:          0
> LOC:      32554
> ERR:          0
> MIS:          0

Alan Cox pointed out this problem to me and hinted that it was an IRQ
routing problem, i'm not sure wether it is possible to code workarounds
which don't break normal systems though. Anyone want to use Jim as a
guinea ping? ;)


