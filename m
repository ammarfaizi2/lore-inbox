Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUGZMrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUGZMrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 08:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUGZMrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 08:47:32 -0400
Received: from main.gmane.org ([80.91.224.249]:21464 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265256AbUGZMqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 08:46:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Frederik Himpe <fhimpe@pandora.be>
Subject: Re: 2.6.7-ck5: System hangs under constant load
Date: Mon, 26 Jul 2004 14:46:34 +0200
Message-ID: <pan.2004.07.26.12.46.33.38548@pandora.be>
References: <200407252227.05580.rototor@rototor.de> <pan.2004.07.25.20.57.36.483562@pandora.be> <200407252321.22781.rototor@rototor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 194.78.190.194
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004 23:21:22 +0200, Emmeran Seehuber wrote:

> Am Sonntag, 25. Juli 2004 22:57 schrieb Frederik Himpe:
>> On Sun, 25 Jul 2004 22:27:05 +0200, Emmeran Seehuber wrote:
>> > Hello everybody!
>> >
>> > I'm using a 2.6.7 kernel with the ck5 patch (gentoo ck-sources). But
>> > the problem I have may not directly be related to this kernel version,
>> > because I had it a few times already with other 2.6.x kernels.
>> >
>> > When I put the machine under constant load (e.g. emerge of kde
>> > 3.3beta2), it works for some hours without problems. But then the
>> > machine suddenly hangs. "Hang" means that no keyboard or mouse input
>> > works (even SysRq doesn't work), the screen freezes and the cpu seems
>> > to go into a loop. The system is a laptop and I hear the fan spin
>> > loudly. And the fan doesn't stop to spin nor turns down the sound,
>> > even after some hours. (Well, I start the emerge and then let the
>> > computer alone for some hours, in the hope that it finishes it ...
>> > when I come back, it hangs)
>>
>> Interesting, as I'm having also a problem with random hangs since kernel
>> 2.6.6 (2.6.5 and before worked fine), also on a laptop. Which laptop do
>> you have? I'm using a Compaq EVO N1020v, with this hardware:
>>
>>
> I've got a Xeron laptop with this hardware:

[...]

Thanks, it seems especially the network chip (Realtek 8139) is similar,
and both have a graphics chip based on radeon (although this one is an
integrated thing).

I have put more detailed information (dmesg, lsmod,
config, lspci -v) on http://users.telenet.be/fhimpe/kernelbug/ . Maybe you
could also make it available somewhere?

Is there a kernel hacker who could give us any clue about what we can do
to get more information to find the exact cause and to solve this problem?

Frederik

