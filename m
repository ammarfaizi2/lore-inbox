Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262976AbTC1NRM>; Fri, 28 Mar 2003 08:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262977AbTC1NRL>; Fri, 28 Mar 2003 08:17:11 -0500
Received: from p5082010B.dip0.t-ipconnect.de ([80.130.1.11]:16829 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S262976AbTC1NRL>;
	Fri, 28 Mar 2003 08:17:11 -0500
To: Warren Turkal <wturkal@cbu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] laptop keyboard, even more info
From: Arne Koewing <ark@gmx.net>
Date: Fri, 28 Mar 2003 10:05:16 +0100
In-Reply-To: <200303232056.06284.wturkal@cbu.edu> (Warren Turkal's message
 of "Fri, 28 Mar 2003 01:04:54 -0600")
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <200303220605.54478.wturkal@cbu.edu>
	<200303232056.06284.wturkal@cbu.edu>
Message-ID: <87y92zr57o.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warren Turkal <wturkal@cbu.edu> writes:

> On Sunday 23 March 2003 08:36 pm, Warren Turkal wrote:
>> I am not subscribed. Please cc on replies.
>>
>> I have a Gateway 600 series notebook. I have been using and testing the
>> developmental kernel for some time now. I have just noticed that my
>> keyboard''s "fn" key combinations stop working upon booting 2.5.65. They
>> worked as recently as 2.5.63 and I could not get 2.5.64 to compile cleanly.
>> These key combinations are supposed to make various things happen on my
>> laptop. I believe that they are controlled by the bios, as I can see
>> results of some while on the bios load screen.
>>
...
>>
>> I have tested that the Fn-F2 combination works in bios and grub and
>> continues to work until the 2.5.65 kernel is loaded.
>>
>> I think this is a regression in the keyboard handling for the 2.5.65
>> kernel.
...

I don't think this is caused by the input-layer. Linux is not passing
Fn-X keypresses to your BIOS. If you've enabled ACPI that ought to be
the reason for this.
 
Arne
 
