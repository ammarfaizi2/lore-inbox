Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTI1Mfy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 08:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTI1Mfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 08:35:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:55839 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262529AbTI1Mfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 08:35:52 -0400
Date: Sun, 28 Sep 2003 13:34:41 +0100
From: Dave Jones <davej@redhat.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928123432.GA23693@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andreas Jellinghaus <aj@dungeon.inka.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <pan.2003.09.28.11.05.34.596021@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.09.28.11.05.34.596021@dungeon.inka.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 01:05:35PM +0200, Andreas Jellinghaus wrote:
 > test6 (plus hostap patch) hangs during boot.
 > The last line I see is 
 > cpufreq: Intel(R) SpeedStep(TM) for this chip set not (yet) available.

Does it still hang if you disable the speedstep driver ?

 > and with test5 the next line would be:
 > IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
 > 
 > booted with parameters:
 > kernel /vmlinuz-2.6.0-test6 root=/dev/hda2 ro hda=2432,255,63 resume=/dev/hda3
 > elevator=deadline psmouse_noext
 > 
 > but without the last three params it didn't change anything.

What happens if you don't pass the hda geometry ?
And, why do you need to ?

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
