Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbTARKBK>; Sat, 18 Jan 2003 05:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264617AbTARKBK>; Sat, 18 Jan 2003 05:01:10 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:40719 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264614AbTARKBJ>; Sat, 18 Jan 2003 05:01:09 -0500
Date: Sat, 18 Jan 2003 11:09:55 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 doesn't boot - hangs after 'Uncompressing the kernel'
Message-ID: <20030118100955.GB1138@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030118081408.GA1163@middle.of.nowhere> <20030118093743.GB1483@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030118093743.GB1483@mars.ravnborg.org>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, Jan 18, 2003 at 10:37:43AM +0100
> On Sat, Jan 18, 2003 at 09:14:08AM +0100, Jurriaan wrote:
> > I can't get 2.5.59 to boot on my dual tualatin/via PRO266T system.
> > It hangs early in the boot-process, I don't see anything after the
> > 'Uncompressing the kernel' line. The keyboard led's stuck then as well,
> > and waiting doesn't help.
> 
> People have problems after recent changes in vmlinux.lds.
> 
> Try apply the vmlinux patch from Andrew's set of patches:
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm2/
> 
> Usually report is an oops, but that may be UP only.
> 
No change, both 2.5.59-mm2 and 2.5.59 + the mm2 vmlinux patch hang just
in the same way.

This is on a Debian/Unstable system, btw.

Jurriaan
-- 
"Not today, not tomorrow, not last year, not at the second coming
of Julius Feistersnap. In short, never, and not even then! Does
that set matters straight?"
        Jack Vance - Araminta Station
GNU/Linux 2.5.53 SMP/ReiserFS 2x2752 bogomips load av: 0.08 0.08 0.05
