Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWCRGIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWCRGIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 01:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWCRGIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 01:08:53 -0500
Received: from sip2.vilos.com ([69.90.134.213]:20685 "EHLO mail.tig-grr.com")
	by vger.kernel.org with ESMTP id S1751470AbWCRGIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 01:08:52 -0500
Date: Fri, 17 Mar 2006 22:08:46 -0800
From: Tom Marshall <tommy@home.tig-grr.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-announce] Nigel's work and the future of Suspend2.
Message-ID: <20060318060846.GA11546@home.tig-grr.com>
References: <200603071005.56453.nigel@suspend2.net> <20060308122500.GB3274@elf.ucw.cz> <1141839915.5382.49.camel@marvin.se.eecs.uni-kassel.de> <200603082139.06259.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603082139.06259.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 09:39:05PM +0100, Rafael J. Wysocki wrote:
> On Wednesday 08 March 2006 18:45, Thomas Maier wrote:
> > Am Mittwoch, den 08.03.2006, 13:25 +0100 schrieb Pavel Machek:
> > > On ??t 07-03-06 14:14:00, Thomas Maier wrote:
> }-- snip --{
> > > > Mainline swsusp never worked for me and
> > > > so with you leaving I am tempted to leave Linux behind after more than
> > > > ten years and switch to that other OS that at least has working suspend
> > > > and resume.
> 
> Frankly that's something I really don't understand.  swsusp is supposed to
> work (actually with 2.6.16-rc5-mm2 it works for me 100% of the time) and
> if it doesn't work for you, there's a bug and it should be fixed.  Yet, you
> don't report it, so it is unknown to anyone except for you and there's no
> hope anyone will actually work on fixing it.

I have the opposite problem, more or less (S3 not swsusp):

I have two identical (except for different model drives) Thinkpad T42
laptops that exhibit the same behavior.  S3 mostly works but occasionally
fails to resume, for values of occasionally that vary between 1-2 successful
resumes before failure to several dozens.

Unfortunately, having recently been bitten by kernel-userspace API breakages
(probably udev but it's been a while ago and I don't really care anymore)
for the first time in a decade of constant Linux usage, I have not tracked
mainline since about 2.6.12 and instead rely on my vendor kernel plus
private patches as recommended over and over on this list.  Therefore, no
bug report from me.  But I have the highest confidence that someone with a
Centrino laptop and enough free time to run the most recent vanilla kernel
will eventually file a bug and some kernel developer will eventually fix it. 
In the meantime, I just rely on swsusp or pray that a pre-S3 "sync" and ext3
journalling will be good enough.  Sad but true.

If anyone is willing to work with me on tracking down the issue in a vendor
kernel (Ubuntu Dapper), I would be more than happy to apply debug patches
and supply any debug info requested.

-- 
Write a wise saying and your name will live forever.
        -- Anonymous
