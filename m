Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTDIUcM (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTDIUcM (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:32:12 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:35202 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263792AbTDIUcL (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 16:32:11 -0400
Subject: Re: 2.5.67, 2.5-bk lock up with RH 9 and graphical log out.
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1049904293.24463.25.camel@spc9.esa.lanl.gov>
References: <1049904293.24463.25.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Organization: 
Message-Id: <1049921014.592.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 09 Apr 2003 22:43:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 18:04, Steven Cole wrote:
> With kernel 2.5.67 or 2.5-bk-current and Red Hat 9, if I try to do a
> graphical log out from either KDE or Gnome, the test machine locks up
> hard, not responding to pings, or alt-sysrq-anything. (and yes,
> /proc/sys/kernel/sysrq is 1 and I "fixed" /etc/sysctl.conf, line 13)
> 
> The same lockup happens with ctrl-alt-backspace from KDE or Gnome.
> 
> Doing an /sbin/init 3 works fine.  Harsh way to log out however.
> Subsequent cycles of startx and graphical "Log Out" do _not_ lock up
> the box, but work just fine.
> 
> Needless to say, with the vendor kernel, everything works perfectly. 
> Alt-sysrq-various behaves as expected. Ctrl-alt-backspace does not
> lock up the box.
> 
> If I get time, I'll try some older 2.5.x kernels to see if this is a
> recently introduced behavior.

.config? Are you using Framebuffer console support?
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

