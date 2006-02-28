Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWB1U2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWB1U2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWB1U2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:28:51 -0500
Received: from mail.freedom.ind.br ([201.35.65.90]:40655 "EHLO
	mail.freedom.ind.br") by vger.kernel.org with ESMTP id S932557AbWB1U2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:28:51 -0500
From: Otavio Salvador <otavio@debian.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*
Organization: O.S. Systems Ltda.
References: <87wtfhx7rm.fsf@nurf.casa> <s5hzmkcsv38.wl%tiwai@suse.de>
	<87slq3x3w1.fsf@nurf.casa> <s5hu0ajrbxv.wl%tiwai@suse.de>
X-URL: http://www.debian.org/~otavio/
X-Attribution: O.S.
Date: Tue, 28 Feb 2006 17:28:36 -0300
In-Reply-To: <s5hu0ajrbxv.wl%tiwai@suse.de> (Takashi Iwai's message of "Tue,
	28 Feb 2006 11:54:04 +0100")
Message-ID: <87fym3w7m3.fsf@nurf.casa>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> At Tue, 28 Feb 2006 05:51:26 -0300,
> Otavio Salvador wrote:
>> 
>> > This kind of problem is likely due to a broken BIOS.  The current code
>> > parses the default pin configuration set up via BIOS while the older
>> > version used  the fixed pin assignment (depending on the codec chip,
>> > though).
>> > In most cases, it can be recovered by specifying a proper model module
>> > option.  See ALSA-Configuration.txt for details.
>> 
>> I wasn't able to do it.
>
> Didn't it worked?  Which module parameter did you use?

I tried model=hp, model=fujistsu and priority_fix={1,2}. Neither did
it work.

>> I hope it helps.
>
> I need more detail of the hardware -- what model of a laptop or a
> desktop from which vendor.

http://www.ctlnotebooks.com/v2/notebook_spec.aspx?id=21&hdr=Products

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."
