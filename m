Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWBTANX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWBTANX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWBTANW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:13:22 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:21678 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932476AbWBTANV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:13:21 -0500
Date: Sun, 19 Feb 2006 16:12:17 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Pavel Machek <pavel@suse.cz>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
In-Reply-To: <1140393928.2733.441.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0602191608330.10888@qynat.qvtvafvgr.pbz>
References: <20060218231419.GA3219@elf.ucw.cz><200602192323.08169.s0348365@sms.ed.ac.uk><1140391929.2733.430.camel@mindpipe><200602192356.39834.s0348365@sms.ed.ac.uk>
 <1140393928.2733.441.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2006, Lee Revell wrote:

> On Sun, 2006-02-19 at 23:56 +0000, Alistair John Strachan wrote:
>> Thanks for this info Lee, and understand I don't hold anybody
>> specifically in
>> the alsa team responsible but *deep breath*:
>>
>> Please let everybody know about incompatible changes to alsa-lib know
>> about it
>> prior to making the change mandatory.
>
> I thought it was already common knowledge that alsa-lib should be
> upgraded when upgrading the kernel.

it's not (at least among general Linux users, it probably is among alsa 
developers).

Especially after the comments that Linus made a few months ago about how 
important it is to not break userspace interfaces.

> Each ALSA driver has both a userspace and a kernel component so alsa-lib
> has to be upgraded to get new drivers anyway.

but people frequently upgrade kernels on existing machines so they aren't 
after new drivers.

if alsalib really needs to be upgraded in lockstep with the kernel then it 
should be included with the kernel (and it still leaves people in trouble 
when they need to shift back and forth between two different kernels, how 
do you select the alsalib version to use on boot to make it match the 
kernel you booted from?)

David Lang

> Lee
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

