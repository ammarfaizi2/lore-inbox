Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWGPQjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWGPQjs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWGPQjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:39:48 -0400
Received: from khc.piap.pl ([195.187.100.11]:14210 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751129AbWGPQjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:39:47 -0400
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17.3 kernel panic
References: <m3psg5a5lp.fsf@defiant.localdomain>
	<6bffcb0e0607160926h25ae8171kf2785f731a62fb6b@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 16 Jul 2006 18:39:46 +0200
In-Reply-To: <6bffcb0e0607160926h25ae8171kf2785f731a62fb6b@mail.gmail.com> (Michal Piotrowski's message of "Sun, 16 Jul 2006 18:26:58 +0200")
Message-ID: <m3lkqta4h9.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> writes:

>> c010ae3d T do_page_fault
>> c010b368 t .text.lock.fault
> [snip]
>>
>> What could it be?
>> How could I debug it?
>
> please try
> gdb vmlinux
> list *0xc010b247

I actually included listing of the code fragment in question (both
assembly and C).
-- 
Krzysztof Halasa
