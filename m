Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTJ3UAX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 15:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTJ3UAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 15:00:23 -0500
Received: from main.gmane.org ([80.91.224.249]:42964 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262789AbTJ3UAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 15:00:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Christian Kapeller <christian.kapeller@gmx.net>
Subject: Re: [2.6.0-test9] alsa intel8x0: scattered sound playback
Date: Thu, 30 Oct 2003 19:32:29 +0100
Message-ID: <slrnbq2m9t.ne.christian.kapeller@campus14.panorama.sth.ac.at>
References: <slrnbpvkdj.845.christian.kapeller@campus14.panorama.sth.ac.at> <s5hy8v3x9dl.wl@alsa2.suse.de>
Reply-To: christian.kapeller@gmx.net
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> schrieb:
> At Wed, 29 Oct 2003 15:41:55 +0100,
> Christian Kapeller wrote:
>> 
>> Hi!
>> 
>> Since i'm running the 2.6.0 (2.6.0-test9-bk1 currently) kernel i encounter 
>> problems with alsa sound playback.
>> 
>> I got a Thinkpad A31 with Debian, so i use the intel8x0 driver. I compiled the 
>> drivers into the kernel. The compiling works just fine, also the sound playback 
>> runs without problems.
>> 
>> The sound is very scatterd and parts of the playback are repeated sometims. 
>> Stopping the playback and starting it again, fixes it - somtimes, and if then 
>> only for a couple of seconds.
>
> sounds like interrupts problem...  playing with ACPI ?

Correct. I'm playing with ACPI (Hail to the brave!). But i experienced
the same phenomenon also without PM and APM. Same log-messages, same
symptoms.

