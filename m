Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUDSUOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUDSUOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:14:49 -0400
Received: from spc1-brig1-3-0-cust85.lond.broadband.ntl.com ([80.0.159.85]:7864
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261993AbUDSUOo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:14:44 -0400
Date: Mon, 19 Apr 2004 21:14:41 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KVM issues with recent 2.6 kernels
In-Reply-To: <20040419181159.GA10708@middle.of.nowhere>
Message-ID: <Pine.LNX.4.58.0404192104590.1572@ppg_penguin>
References: <Pine.LNX.4.58.0404191216020.31750@ppg_penguin>
 <20040419181159.GA10708@middle.of.nowhere>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, Jurriaan wrote:

> Does your KVM also have keys on the kvm to switch? If so, does the
> problem go away if you use those?
>

 I was about to say the problem doesn't appear like that (it just takes
an age to cycle through all 4 boxes), but I thought I'd better try it -
guess what, the alt key is no longer functioning on the duron/2.6.5 box
when I go to it like that.  I've now gone back to it using key presses
and it sorted itself out after I threw in an extra press of the scroll
lock (the xterm was responding, unlike console sessions, it was only the
alt key that seemed to be swallowed).  At least I've now found out a way
to fix the immediate "loss of alt key" problem - thanks !

> Otherwise, perhaps hack drivers/input/keyboard/atkbd.c (dunno if that is
> the correct path) to log when a scroll-lock is received) and then throw
> away that keypress?
>

 Interesting idea, but I've got enough trouble with userspace apps
without hacking the kernel, and anyway /some/ of the scroll-lock
keypresses are needed to get directly to the desired session.

> Good luck,
> Jurriaan
>

-- 
 das eine Mal als Tragödie, das andere Mal als Farce

