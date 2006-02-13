Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWBMMiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWBMMiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBMMiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:38:08 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:31731 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932421AbWBMMiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:38:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=aTpyw8IHL+Lo2pzBGhYrVVPc2GQw7NsOHF7auc/nV6hnzRIDh6DVP92xhDu05mm1FY6BDou0S6nMdq8suCb+oJtkkGzn/vDk4lky4Lw+PJr70mMQ5X9M5QmNI4J7MQYYiL6kam617/7ZdNmMfAbptZKHOYqy7xjkFDXgBaDLUYo=
Message-ID: <43F07DA3.6080702@gmail.com>
Date: Mon, 13 Feb 2006 13:37:55 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, Greg KH <greg@kroah.com>,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       =?ISO-8859-1?Q?Gerrit_Bruchh=E4us?= =?ISO-8859-1?Q?er?= 
	<gbruchhaeuser@gmx.de>,
       Nicolas.Mailhot@LaPoste.net, Jaroslav Kysela <perex@suse.cz>,
       =?ISO-8859-1?Q?Bj=F6rn_Nilsson?= <bni.swe@gmail.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>, "P. Christeas" <p_christ@hol.gr>,
       ghrt <ghrt@dial.kappa.ro>, jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Linux 2.6.16-rc3
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>	<20060212190520.244fcaec.akpm@osdl.org> <s5hk6bz4gca.wl%tiwai@suse.de>
In-Reply-To: <s5hk6bz4gca.wl%tiwai@suse.de>
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai ha scritto:
> At Sun, 12 Feb 2006 19:05:20 -0800,
> Andrew Morton wrote:
>   
>> - Patrizio Bassi <patrizio.bassi@gmail.com> has an alsa suspend
>>   regression ("alsa suspend/resume continues to fail for ens1370")
>>     
>
> It's not a "regression".  PM didn't work with ens1370 at all in the
> eralier version.
>
> About the problem there, I have no idea now what's wrong.  The
> suspend-to-disk works fine if the driver is built as module but not as
> built-in kernel.
>
>
>   
i wrote "regression" because before (ehm...exactly don't know...about
2.6.14 time)
after suspend i had to restart my distro's mixer values service or i
couldn't hear anything.
and...ok..it was boring but worked.

now i get 0x660 errors if i try to restore values and device seems dead,
just flood the syslog.
sound apps slow down (like 100% cpu usage) and no sound produced.

only fix is reboot.


>> - ghrt <ghrt@dial.kappa.ro> reports an alsa regression ("PROBLEM: SB
>>   Live!  5.1 (emu10k1, rev.  0a) doesn't work with 2.6.15")
>>     
>
> I couldn't find this bugzilla entry...
>
>
> Takashi
>
>   

