Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTLXSGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 13:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTLXSGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 13:06:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:18610 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263726AbTLXSGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 13:06:50 -0500
Date: Wed, 24 Dec 2003 10:04:46 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: lkml <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: [bug] 2.6.0 COMMAND_LINE_SIZE <160???
Message-Id: <20031224100446.229721fe.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312241804470.21411@silk.corp.fedex.com>
References: <Pine.LNX.4.58.0312232102340.5732@silk.corp.fedex.com>
	<20031223092104.6bc9f634.rddunlap@osdl.org>
	<Pine.LNX.4.58.0312241804470.21411@silk.corp.fedex.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Dec 2003 18:11:54 +0800 (SGT) Jeff Chua <jeffchua@silk.corp.fedex.com> wrote:

| 
| On Tue, 23 Dec 2003, Randy.Dunlap wrote:
| 
| > On Tue, 23 Dec 2003 21:07:45 +0800 (SGT) Jeff Chua <jeffchua@silk.corp.fedex.com> wrote:
| >
| > Same processor arch. type in both .config files?
| > Same compiler version building them?
| 
| Same for both.
| 
| gcc 2.95.3 20010315
| glibc-2.2.5-34
| 
| perhaps, it's loadlin or linld problem, or fat32 problem. The difference
| is lilo doesn't need _dos_ to boot.

Just curious, what kind of disk/OS config do you have where
using loadlin (or linld) is useful?  Does it have anything to do
with not writing (updating) the MBR on disk?
Are there some booting alternatives for you?

Is Linux on the same hard disk as Windows (or DOS)?

| I tried to replace ./arch/i386/boot/setup.S with the one from 2.4.24-pre1
| and it seems to go further before it breaks.

Yes, not much difference in those source files.

| What's next to debug this?

Good question.  I'm not sure.  Anyone else have suggestions?

--
~Randy
