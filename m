Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUCOQbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 11:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbUCOQbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 11:31:41 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:51873 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S262606AbUCOQbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 11:31:39 -0500
Date: Mon, 15 Mar 2004 17:29:44 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Dave Jones <davej@redhat.com>
Cc: Isaku Yamahata <yamahata@private.email.ne.jp>,
       George Hansper <ghansper@apana.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA MIDI serial u16550 horribly broken in 2.6.4
In-Reply-To: <20040315161047.GA19555@redhat.com>
Message-ID: <Pine.LNX.4.58.0403151728380.13684@pnote.perex-int.cz>
References: <20040315161047.GA19555@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004, Dave Jones wrote:

> poking io port 0x1 probably isn't going to do much good.
> Here's what happens after a 'modprobe snd_serial_u16550'

Thanks. I've fixed this problem in our CVS tree. The oops should
be fixed in the current Linus's tree, too.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
