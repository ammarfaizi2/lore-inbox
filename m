Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271199AbTG2Anm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 20:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271207AbTG2Anm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 20:43:42 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:15528
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271199AbTG2Anl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 20:43:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Diego Calleja =?iso-8859-15?q?Garc=EDa?= <diegocg@teleline.es>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test2-mm1
Date: Tue, 29 Jul 2003 10:47:55 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <20030727233716.56fb68d2.akpm@osdl.org> <20030729023844.2df2fef5.diegocg@teleline.es>
In-Reply-To: <20030729023844.2df2fef5.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307291047.55700.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 10:38, Diego Calleja García wrote:
> El Sun, 27 Jul 2003 23:37:16 -0700 Andrew Morton <akpm@osdl.org> escribió:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2
> >/2.6.0-test2-mm1/
> >
> > - More CPU scheduler tweaks.
>
> O10 feels great here; behaviour under heavy load (make -jbignumber) is
> great; gcc doesn't starves the rest of the processes; it still allows
> X/xchat/xmms/etc do some work and the system remains usable; mp3 doesn't
> skip too much (only when it tries to swapin some big process like galeon
> but i find that normal; before this the same load in the past starved
> anything not classified as "compiler").

Thanks. The swap or even heavy vm thing affecting interactivity is something 
I've been thinking about for some time but I've yet to figure out a good way 
to feed back the vm's activity into the scheduler in a meaningful way.

Con

