Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273822AbRI2Jmw>; Sat, 29 Sep 2001 05:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273830AbRI2Jml>; Sat, 29 Sep 2001 05:42:41 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:18443 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S273822AbRI2Jmh>;
	Sat, 29 Sep 2001 05:42:37 -0400
Date: Sat, 29 Sep 2001 11:43:04 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Makefile gcc -o /dev/null: the dissapearing of /dev/null
Message-ID: <20010929114304.A21440@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BB57E77.4CDFF5D0@energymech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB57E77.4CDFF5D0@energymech.net>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-29 09:55:35 +0200, proton <proton@energymech.net>
wrote in message <3BB57E77.4CDFF5D0@energymech.net>:

> Ofcourse, you cant unlink /dev/null unless you are root.

That's right and fine so far.

> In any case, the `gcc -o /dev/null' test cases probably
> need to go away.

No. Why? Well, the Linux kernel compiles just fine while
being an ordianary user. You don't have to be root to 
compile it. As it's just bad to do usual *work* as root,
you're the bug.

	*	Don't		*
	*	work		*
	*	with		*
	*	UID root	*
	*	if		*
	*	you		*
	*	don't		*
	*	need		*
	*	to		*
	*	! ! !		*

MfG, JBG

-- 
Jan-Benedict Glaw . jbglaw@lug-owl.de . +49-172-7608481
