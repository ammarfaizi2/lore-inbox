Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbUC0VHn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 16:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUC0VHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 16:07:43 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:58240 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261874AbUC0VHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 16:07:41 -0500
Date: Sun, 28 Mar 2004 05:01:32 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: Luke-Jr <luke-jr@artcena.com>, swsusp-devel@lists.sourceforge.net
Subject: Paranoia is fun [Was Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]]
Cc: "Micha Feigin" <michf@post.tau.ac.il>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20040323233228.GK364@elf.ucw.cz> <200403270440.47737.luke-jr@artcena.com> <20040327195009.GA2737@luna.mooo.com> <200403272003.35410.luke-jr@artcena.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5jgous34evsfm@smtp.pacific.net.th>
In-Reply-To: <200403272003.35410.luke-jr@artcena.com>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This thread mutates fast :)

On Sat, 27 Mar 2004 20:03:35 +0000, Luke-Jr <luke-jr@artcena.com> wrote:

> On Saturday 27 March 2004 07:50 pm, Micha Feigin wrote:
>> If the key is given at resume command line and this is properly
>> forgotten when the resumed kernel kicks in then a user key will also
>> probably be ok.
> The resume command line is usually stored on the same disk as the image in a
> configuration file.
>

... so one really would not want to put the key there.

Each and every shortcut is unsafe as it somwhere has to store the
full key and could be reverse engineered and broken "easily"
relative to breaking the key.

Guess Micha meant to edit the resume command line prior to
boot, which would work at this time.

The only "safe" way is to enter the key when prompted
For references Google for cryptoswap, loop-aes, cryptoapi

Also resuming kernel md5 checksum should flow into the key to
prevent some schlaphut replacing the kernel.  (I know that
it would be  hard  to make  addresses match, but still easier
than breaking the key). So, this is really important.

It was discussed to pass the resume command line on to the
resumed kernel for config, in which case the key should be
stripped prior to doing so.

Michael

P.S.

I say "safe" because it is safe only as long as noone can observe
key entry or touch the machine to install a (keyboard) bug...

BTW, When did we look last into our keyboards and  are we
sure there are no spare chips (bugs) planted in our machines ;)

Well, perhaps we need linux computers implanted into our teeth
so that we can be "more" safe. The key could be transmitted
by tongue using (morse) code however (unauthorized) third party
objects must be prevented from entering the mouth to prevent spying.

Well, should I mention what could be hidden _on_ those bloody chips.

Have a nice day.

