Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbULAQBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbULAQBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbULAQBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:01:21 -0500
Received: from zamok.crans.org ([138.231.136.6]:37331 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261290AbULAQBC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:01:02 -0500
To: linux-os@analogic.com
Cc: John Que <qwejohn@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: intird.img file missing - cannot boot.
References: <BAY14-F2141AE33478CA464C1B3C7AFBF0@phx.gbl>
	<Pine.LNX.4.61.0412011031460.4358@chaos.analogic.com>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Wed, 01 Dec 2004 17:01:12 +0100
In-Reply-To: <Pine.LNX.4.61.0412011031460.4358@chaos.analogic.com>
	(linux-os@chaos.analogic.com's message of "Wed, 1 Dec 2004 10:38:04
	-0500 (EST)")
Message-ID: <87vfbmvwhj.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@chaos.analogic.com> disait dernièrement que :

> On Wed, 1 Dec 2004, John Que wrote:
>
>> Hello,
>>
>> I had made some tests with mkinitrd , I deleted /boot/intird-2.6.7.img
>> and booted (without renaming the /boot/intird-2.6.7.img.old I have
>> to intird-2.6.7.img).
>>
>> I use this intird-2.6.7.img image in boot (ext3 is not part of the
>> kernel image).
>> (I am working with Fedora with 2.6.7 , and with grub).
>>
>> So when booting I get the mesages:
>> ....
>> /intrd/intird-2.6.7.img
>> error 15: File Mot Fount
>> ...
>>
>> what should I do ? can I use a Fedora boot diskette and then
>> mount the boot partition and rename the file ? (the
>> intird-2.6.7.img.old is , as
>> I said,under boot)
>> How can I do this mounting?
>> (If I remember well , a boot CD like KNPOIX does not have write permissions.)
>>
>> Regards,
>> John
>>
>
> When you get to the blue boot screen, just select another boot image
> and boot that.

or if you know the name of the initrd you want to use in place of the regular,
you can use 'e' key to edit the entry you want; just change the name of the
initrd file to the right one. and boot it with 'b' key.
Being able to change the boot configuration at boot time is the very one of my
prefered features GRUB has and lilo does not.
>
> If you have mucked with the original and have no others, boot
> from the installation CD. Follow the "repair" prompts. Eventually
> your partition will be mounted somewhere and you can fix it.
> If you have a seperate /boot partition, just mount that and
> rename the file back or edit grub.conf to show the right one
> that goes with the right image.

if he knows where the real initrd is, no need to go thru the repair procedure,
editing the boot entries at boot time is possible with the grub.

-- 
> Can you explain this behaviour?

Yes
--
Alan

[Oh wait you want to know why...]

	- Alan Cox on linux-kernel

