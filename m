Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbTDJONY (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264049AbTDJONY (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:13:24 -0400
Received: from AStrasbourg-204-1-3-163.abo.wanadoo.fr ([81.51.134.163]:8906
	"EHLO kalman") by vger.kernel.org with ESMTP id S264048AbTDJONW (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 10:13:22 -0400
Date: Thu, 10 Apr 2003 16:25:06 +0200
From: Bruno Boettcher <bboett@adlp.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67 compile problem...
Message-ID: <20030410142506.GM29225@adlp.org>
Reply-To: bboett@adlp.org
Mail-Followup-To: Bruno Boettcher <bboett@adlp.org>,
	linux-kernel@vger.kernel.org
References: <20030408180604.GA3709@adlp.org> <200304082056.12305.freesoftwaredeveloper@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200304082056.12305.freesoftwaredeveloper@web.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 08:56:12PM +0200, Michael Buesch wrote:
> This may fix it. (It's not tested)
partly :D


In file included from include/linux/mca.h:132,
                 from drivers/block/ps2esdi.c:42:
include/linux/mca-legacy.h:10:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
drivers/block/ps2esdi.c: In function `init_module':
drivers/block/ps2esdi.c:185: warning: initialization from incompatible pointer type
drivers/block/ps2esdi.c:188: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:188: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:189: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:192: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:193: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:195: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c: In function `do_ps2esdi_request':
drivers/block/ps2esdi.c:505: warning: long long unsigned int format, different type arg (arg 3)
drivers/block/ps2esdi.c: In function `ps2esdi_out_cmd_blk':
drivers/block/ps2esdi.c:626: warning: comparison of distinct pointer types lacks a cast
drivers/block/ps2esdi.c:649: warning: comparison of distinct pointer types lacks a cast
make[2]: *** [drivers/block/ps2esdi.o] Fehler 1

besides debugging this one....
for what is it needed, and can i safely (question there, where?) switch it off, to be able to at least give this 2.5 kernel a test shot?

please add me through CC to any answer

-- 
ciao bboett
==============================================================
bboett@adlp.org
http://inforezo.u-strasbg.fr/~bboett
===============================================================
