Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSGUULs>; Sun, 21 Jul 2002 16:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSGUULs>; Sun, 21 Jul 2002 16:11:48 -0400
Received: from pele.santafe.edu ([192.12.12.119]:44250 "EHLO pele.santafe.edu")
	by vger.kernel.org with ESMTP id <S315198AbSGUULr>;
	Sun, 21 Jul 2002 16:11:47 -0400
Date: Sun, 21 Jul 2002 14:14:41 -0600 (MDT)
Message-Id: <200207212014.g6LKEfn00823@aztec.santafe.edu>
From: Richard Stallman <rms@gnu.org>
To: alan@redhat.com
CC: eggert@twinsun.com, linux-kernel@vger.kernel.org, alan@redhat.com
In-reply-to: <200207200038.g6K0cZO12086@devserv.devel.redhat.com> (message
	from Alan Cox on Fri, 19 Jul 2002 20:38:35 -0400 (EDT))
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
Reply-to: rms@gnu.org
References: <200207200038.g6K0cZO12086@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    This is extremely useful behaviour. POSIX is broken here. Fix it in the
    C library or somewhere it doesn't harm the clueful

Why is it useful?  For signal handlers to see how much waiting time is
left?
