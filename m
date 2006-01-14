Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWANUzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWANUzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 15:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWANUzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 15:55:00 -0500
Received: from nsm.pl ([62.111.143.37]:64014 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1751117AbWANUzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 15:55:00 -0500
Date: Sat, 14 Jan 2006 21:54:48 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Daniel Petrini <d.pensator@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-ck1
Message-ID: <20060114205448.GA17764@irc.pl>
Mail-Followup-To: Daniel Petrini <d.pensator@gmail.com>,
	linux-kernel@vger.kernel.org
References: <200601041200.03593.kernel@kolivas.org> <20060105175821.GA4010@irc.pl> <200601061022.46026.kernel@kolivas.org> <20060107131633.GB9197@irc.pl> <9268368b0601131119n639c345cgcf2a5dadd7cb423c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9268368b0601131119n639c345cgcf2a5dadd7cb423c@mail.gmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 03:19:29PM -0400, Daniel Petrini wrote:
> Hi Tomasz,
> 
> Just to make sure if there isn't any timer that is not visible in the
> screen (unlikely but...). Can you run timertop with background
> acquisition:
> 
> timertop -t 100
> 
> And analyse the output to verify if there isn't timers with that frequency?

  Nothing suspicious:


Timer Top v 0.9.8
No.   PID         Command      Count         Function       Address 
  1  4072   multiload-apple        3        process_timeout c0121e08
  2  3602                 X       17             it_real_fn c011deff
  3  3985            python       45        process_timeout c0121e08
  4  4492        postmaster        7        process_timeout c0121e08
  5  3931          nautilus        1        process_timeout c0121e08
  6  4074              mono        9        process_timeout c0121e08
  7  4059     mixer_applet2        7        process_timeout c0121e08
  8  4713             mrxvt        3        process_timeout c0121e08
  9     0                 -        4       i8042_timer_func c0230f2b
 10     1              mono        1       watermark_wakeup c013f6f5
 11    18              mono        3               (module) e2a3409b
 12  4122              mono        2        process_timeout c0121e08
 13     0                 -        1               (module) e2bc2381
 14     0                 -        1            wb_timer_fn c013acc0
 15     0                 -        3  delayed_work_timer_fn c0126a96
 16     0                 -        1     blk_unplug_timeout c01ccc1b
 17     0                 -        1               (module) d0697f40
 18     3        watchdog/0        1        process_timeout c0121e08
 19  4067   netspeed_applet        1        process_timeout c0121e08
 20  4069    cpufreq-applet        1        process_timeout c0121e08
 21  3796   gnome-screensav        1        process_timeout c0121e08
 22  4540             httpd        1        process_timeout c0121e08
 23  3512              ntpd        1             it_real_fn c011deff
 24 17603          timertop        1        process_timeout c0121e08

-- 
Tomasz Torcz               "Never underestimate the bandwidth of a station
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray

