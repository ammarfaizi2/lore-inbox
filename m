Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267318AbUG1Q1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267318AbUG1Q1U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267308AbUG1QZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:25:39 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:44253 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S267316AbUG1QWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:22:31 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Dexter Filmore <Dexter.Filmore@gmx.de>
Date: Wed, 28 Jul 2004 18:19:16 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: whining noise - possible bug in nForce2 support?
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <D6B29052995@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jul 04 at 23:36, Dexter Filmore wrote:
> 
> Just upgraded my mobo to a ECS N2U400-A nForce2 board, standard MCP
> southbridge, latest BIOS.
> CPU is AMD Athlon XP 1800+, 2x256MB PC266 RAM.
> Kernel version is 2.6.7, tested distros are Slackware 10 and Knoppix 3.4.
> 
> Board work alright so far, but as soon as I start a 2.6 kernel, the board will
> produce a high pitched whining sound.
> 
> Interesting thing: as long as the hard disk has something to do, the noise
> vanishes but returns as soon as the disk idles again.

Are you sure that it has something to do with disk and not with processor?
What if you run 'while true; do :; done', is not it sufficient to get
rid of noise?

If it is sufficient, then rebuild your kernel with HZ=100 instead of 
using default 1000Hz. At least it silenced my Compaq notebook.
                                                   Best regards,
                                                      Petr Vandrovec
                                                      

