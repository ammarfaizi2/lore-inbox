Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTLXKNe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 05:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTLXKNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 05:13:34 -0500
Received: from mx13.sac.fedex.com ([199.81.197.53]:17939 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S263510AbTLXKNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 05:13:33 -0500
Date: Wed, 24 Dec 2003 18:11:54 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [bug] 2.6.0 COMMAND_LINE_SIZE <160???
In-Reply-To: <20031223092104.6bc9f634.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.58.0312241804470.21411@silk.corp.fedex.com>
References: <Pine.LNX.4.58.0312232102340.5732@silk.corp.fedex.com>
 <20031223092104.6bc9f634.rddunlap@osdl.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/24/2003
 06:13:29 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/24/2003
 06:13:31 PM,
	Serialize complete at 12/24/2003 06:13:31 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Dec 2003, Randy.Dunlap wrote:

> On Tue, 23 Dec 2003 21:07:45 +0800 (SGT) Jeff Chua <jeffchua@silk.corp.fedex.com> wrote:
>
> Same processor arch. type in both .config files?
> Same compiler version building them?

Same for both.

gcc 2.95.3 20010315
glibc-2.2.5-34

perhaps, it's loadlin or linld problem, or fat32 problem. The difference
is lilo doesn't need _dos_ to boot.

I tried to replace ./arch/i386/boot/setup.S with the one from 2.4.24-pre1
and it seems to go further before it breaks.

What's next to debug this?

Thanks,
Jeff

