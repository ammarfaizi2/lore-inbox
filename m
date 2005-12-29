Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVL2Xul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVL2Xul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVL2Xul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:50:41 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:55447 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751154AbVL2Xul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:50:41 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: gcoady@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6..15-rc7: CONFIG_HOTPLUG help text
Date: Fri, 30 Dec 2005 10:50:51 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <gps8r11901oi7t49voipksseomhqn0bkd9@4ax.com>
References: <drq8r15vvepe8ike7tkm5mkcfp41npph2h@4ax.com> <9a8748490512291519h22c3ad6fvcda35fb038d0f3cf@mail.gmail.com> <0as8r1dh78udset3vv3d1sea5lpnkqccoi@4ax.com> <9a8748490512291535i3b58b99ex80e3e45d7ebeac22@mail.gmail.com>
In-Reply-To: <9a8748490512291535i3b58b99ex80e3e45d7ebeac22@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Dec 2005 00:35:59 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrote:

>On 12/30/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
>> On Fri, 30 Dec 2005 00:19:03 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>>
>> >On 12/30/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
>> >> Hi there,
>> >>
>> >> "
>> >> CONFIG_HOTPLUG:
>> >>
>> >> This option is provided for the case where no in-kernel-tree
>> >> modules require HOTPLUG functionality, but a module built
>> >> outside the kernel tree does. Such modules require Y here.
>> >> "
>> >>
>> >> This gives no indication it is required for udev.  Or is it me confused?
>> >>
>> >It doesn't mention udev specifically, but it does say quite clearly
>> >that it's for out-of-kernel stuff that requires hotplug, and udev is
>> >such a thing.
>>
>> udev is an out-of-tree kernel module?  Okay, why not bring it into
>> the mainline kernel then?  ;)
>>
>Heh, ok, you are right, I guess my eyes skipped the "module" bit. I
>guess it should say something along the lines of
>
> This option is provided for the case where no in-kernel-tree
> modules require HOTPLUG functionality, but a module (or
> other piece of software, like udev) built outside the kernel
> tree does.
> Such modules and other out-of-tree software require Y here.
> If in doubt say Y.
>
>How's that for a better wording?

I'm not sure if the usage has drifted to udev now, or is valid 
for both udev and also out-of-tree stuff which seems to be now 
discouraged.

I wonder what else should be set for proper udev operation, and 
should it be the default for those arch support it?  IOW is there 
a place for CONFIG_UDEV (or whatever) as user-visible choice to 
switch the feature on/off?

Grant.
