Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265122AbUE0TkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265122AbUE0TkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbUE0TkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:40:07 -0400
Received: from news.cistron.nl ([62.216.30.38]:58544 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S265097AbUE0TjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:39:18 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
Date: Thu, 27 May 2004 19:39:17 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c95g55$oq6$1@news.cistron.nl>
References: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com> <20040520234006.291c3dfa.akpm@osdl.org> <20040524101219.GI5215@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1085686757 25414 62.216.29.200 (27 May 2004 19:39:17 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040524101219.GI5215@openzaurus.ucw.cz>,
Pavel Machek  <pavel@suse.cz> wrote:
>Hi!
>
>> > This patch silences the default i386 boot by putting a lot of development
>> >  related printks under KERN_DEBUG loglevel, allowing the normal chatty mode
>> >  to be turned on by using the 'debug' kernel parameter.
>> 
>> I think I like it chatty.  Turning this stuff off by default makes kernel
>> developers' lives that little bit harder.
>
>Its too chatty these days. Like "APIC debug info hide real errors before that",
>because log buffer is not big enough and scrollback is not enough.
>Please take this one...

I really like it too. Turning off the debug messages makes the
bootup look more professional and clean as well. If you really like
to see the debug stuff you only need to add the parameter to
append= in lilo.conf once.

Mike.

