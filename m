Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVGGVX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVGGVX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVGGVVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:21:42 -0400
Received: from [203.171.93.254] ([203.171.93.254]:1163 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261345AbVGGVU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:20:28 -0400
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200507072054.51480.rjw@sisk.pl>
References: <11206164393426@foobar.com>
	 <1120738525.4860.1433.camel@localhost>
	 <E1DqVp3-00064l-00@chiark.greenend.org.uk> <200507072054.51480.rjw@sisk.pl>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120771312.4860.1569.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 08 Jul 2005 07:21:52 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-07-08 at 04:54, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thursday, 7 of July 2005 14:49, Matthew Garrett wrote:
> > Nigel Cunningham <ncunningham@cyclades.com> wrote:
> > > On Thu, 2005-07-07 at 22:04, Matthew Garrett wrote:
> > >> Do you implement the entire swsusp userspace interface? If not, removing
> > >> it probably isn't a reasonable plan without fair warning.
> > > 
> > > I'm not suggesting removing the sysfs interface or replacing system to
> > > ram - just the suspend to disk part.
> > 
> > Right, so you support the resume from disk trigger in sysfs and the
> > /proc/acpi/sleep interface? If suspend2 is a complete dropin replacement
> > then I'm much happier with the idea of dropping swsusp, but I don't want
> > to have to tie suspend/resume scripts to kernel versions.
> 
> I don't think that swsusp can be replaced with suspend2 right now.  First,
> swsusp works on x86-64, and the support in suspend2 is preliminary,
> AFAIK.  Second, the IA64 support for swsusp is in the works, and it is not supported
> by suspend2.
> 
> Please don't plan to drop swsusp until you are able to replace it _completely_.

Fair enough. I didn't realise Pavel had IA64 support too :>

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

