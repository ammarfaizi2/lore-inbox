Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWAHNqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWAHNqE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 08:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWAHNqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 08:46:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13534 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161008AbWAHNqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 08:46:03 -0500
Date: Sun, 8 Jan 2006 14:21:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, David Lang <dlang@digitalinsight.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
Message-ID: <20060108132132.GA1952@elf.ucw.cz>
References: <E1EuPZg-0008Kw-00@calista.inka.de> <Pine.LNX.4.61.0601050905250.10161@yvahk01.tjqt.qr> <Pine.LNX.4.62.0601051726290.973@qynat.qvtvafvgr.pbz> <20060106053609.GB32105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060106053609.GB32105@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 06-01-06 00:36:09, Dave Jones wrote:
> On Thu, Jan 05, 2006 at 05:28:59PM -0800, David Lang wrote:
>  > On Thu, 5 Jan 2006, Jan Engelhardt wrote:
>  > 
>  > >Also note that the kernel generates a lot of noise^W text - if now the
>  > >start scripts from $YOUR_FAVORITE_DISTRO also fill up, I can barely reach
>  > >the top of the kernel when it says
>  > > Linux version 2.6.15 (jengelh@gwdg-wb04.gwdg.de) (gcc version 4.0.2
>  > > 20050901 (prerelease) (SUSE Linux)) #1 Tue Jan 3 09:21:27 CET 2006
>  > 
>  > enable a few different types of encryption and you have to enlarge the 
>  > buffer (by quite a bit). the fact that all the encryption tests print 
>  > several lines each out and can't be turned off (short of a quiet boot 
>  > where you loose everything) is one of the more annoying things to me right 
>  > now.
>  > 
>  > this large boot message issue also slows your boot significantly if you 
>  > have a fast box that has a serial console, it takes a long time to dump 
>  > all that info out the serial port.
> 
> So disable CONFIG_CRYPTO_TEST. There's no reason to test this stuff every boot.

Maybe even with CRYPTO_TEST enabled we could only report _failures_?
									Pavel
-- 
Thanks, Sharp!
