Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbUCORwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 12:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUCORwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 12:52:16 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:54489 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262647AbUCORwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 12:52:13 -0500
Date: Mon, 15 Mar 2004 17:51:10 +0000
From: Dave Jones <davej@redhat.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Isaku Yamahata <yamahata@private.email.ne.jp>,
       George Hansper <ghansper@apana.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA MIDI serial u16550 horribly broken in 2.6.4
Message-ID: <20040315175110.GS28660@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jaroslav Kysela <perex@suse.cz>,
	Isaku Yamahata <yamahata@private.email.ne.jp>,
	George Hansper <ghansper@apana.org.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040315161047.GA19555@redhat.com> <Pine.LNX.4.58.0403151728380.13684@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403151728380.13684@pnote.perex-int.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 05:29:44PM +0100, Jaroslav Kysela wrote:
 > On Mon, 15 Mar 2004, Dave Jones wrote:
 > 
 > > poking io port 0x1 probably isn't going to do much good.
 > > Here's what happens after a 'modprobe snd_serial_u16550'
 > 
 > Thanks. I've fixed this problem in our CVS tree. The oops should
 > be fixed in the current Linus's tree, too.

Hmm, I don't see it at http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/drivers/serial-u16550.c
Is there somewhere else I should look ?

This was pretty close to top of tree already btw, (only missing
the csets from a few hours ago). I'll test again shortly with top-of-tree.

		Dave

