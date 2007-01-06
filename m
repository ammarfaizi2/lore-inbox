Return-Path: <linux-kernel-owner+w=401wt.eu-S1751001AbXAFAVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbXAFAVz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 19:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbXAFAVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 19:21:55 -0500
Received: from lx1.pxnet.com ([195.227.45.3]:48049 "EHLO lx1.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbXAFAVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 19:21:54 -0500
Date: Sat, 6 Jan 2007 01:21:41 +0100
Message-Id: <200701060021.l060LfD7010759@lx1.pxnet.com>
From: Tilman Schmidt <tilman@imap.cc>
To: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
Cc: Rene Herman <rene.herman@gmail.com>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <4592E685.5000602@gmail.com> <45950DD1.2010208@free.fr> <4595679F.6070905@gmail.com> <200612300025.06088.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2006 00:25:05 -0500, Dmitry Torokhov wrote:
> Somehow you get 2 ACks in a row, I wonder if on your boxes i8042 pumps
> command and data into keyboard before i8042_interrupt gets a chance to
> run.

JFTR, my old Dell Optiplex GX110 with an Intel i810 chipset has the
same problem, and your patch fixes it there, too. So it seems that
this behaviour is not all that unusual.

Thanks
Tilman

