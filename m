Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbUE3MWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUE3MWs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 08:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUE3MWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 08:22:48 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:29162 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263301AbUE3MWa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 08:22:30 -0400
To: Oliver Neukum <oliver@neukum.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Giuseppe Bilotta <bilotta78@hotpop.com>,
       linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
References: <MPG.1b2111558bc2d299896a2@news.gmane.org>
	<20040530101914.GA1226@ucw.cz>
	<xb765aeb1i3.fsf@savona.informatik.uni-freiburg.de>
	<200405301401.20196.oliver@neukum.org>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 30 May 2004 14:22:28 +0200
In-Reply-To: <200405301401.20196.oliver@neukum.org>
Message-ID: <xb7isee9kaj.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Oliver" == Oliver Neukum <oliver@neukum.org> writes:

    >> Where it is now possible to move it out of kernel space WITHOUT
    >> performance problems, why not move it out?

    Oliver> Two reasons: security and robustness.

    Oliver> 1. sysreq must work, always work. Ideally you even do the
    Oliver> dump in hard irq. USB has been modified to support this.

It  doesn't  always work.   Try  to  compile  'i8042' and  'atkbd'  as
modules.  rmmod one of them, and voila: SysRq doesn't work anymore.



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

