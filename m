Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbUE3Lnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUE3Lnm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 07:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUE3Lnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 07:43:42 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:21992 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263169AbUE3LnZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 07:43:25 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
References: <xb7ekp2b34y.fsf@savona.informatik.uni-freiburg.de>
	<20040530112138.GC1377@ucw.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 30 May 2004 13:43:24 +0200
In-Reply-To: <20040530112138.GC1377@ucw.cz>
Message-ID: <xb7vfie9m3n.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

    Vojtech> On Sun, May 30, 2004 at 12:50:05PM +0200, Sau Dan Lee
    Vojtech> wrote:
    >> >> But apart from such debugging use, there is also the more 
    >> >> direct use: in order to assign a keycode to an unusual key one
    >> >> first asks for the scancode using scancode -s, and then
    >> >> assigns the keycode using setkeycodes. If scancode -s lies,
    >> >> this fails.
    >> 
    Vojtech> That's a good reason. I'll implement true rawmode
    Vojtech> support.

    >>  How about mouse?

    Vojtech> Not planned yet. If you can modify your driver to be able
    Vojtech> to coexist with the kernel mouse drivers, like for
    Vojtech> example SCSI drivers can, then I can include it as
    Vojtech> well. But I've not yet found a simple way to do that.

My driver (psmouse.tgz) can already  coexist with the kernel one.  The
SERIO_USERDEV patch  is also  designed to work  _hands in  hands_ with
your kernel-space drivers.

I'm quite disappointed that you are still not aware of that.  Sigh...



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

