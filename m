Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131368AbRCKIBX>; Sun, 11 Mar 2001 03:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbRCKIBD>; Sun, 11 Mar 2001 03:01:03 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:62481 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131368AbRCKIA4>;
	Sun, 11 Mar 2001 03:00:56 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: mingo@elte.hu
cc: Andrew Morton <andrewm@uow.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial console vs NMI watchdog 
In-Reply-To: Your message of "Sun, 11 Mar 2001 08:53:40 BST."
             <Pine.LNX.4.30.0103110852160.1152-100000@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 11 Mar 2001 19:00:09 +1100
Message-ID: <15973.984297609@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Mar 2001 08:53:40 +0100 (CET), 
Ingo Molnar <mingo@elte.hu> wrote:
>it sure has an alternative. The 'cpus spinning' code calls touch_nmi()
>within the busy loop, the polling code on the control CPU too. This is
>sure more robust and catches lockup bugs in kdb too ...

Works for me.  It even makes kdb simpler.

