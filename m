Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVGGS40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVGGS40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVGGS4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:56:15 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:65449 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261463AbVGGSy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:54:56 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
Date: Thu, 7 Jul 2005 20:54:50 +0200
User-Agent: KMail/1.8.1
Cc: ncunningham@cyclades.com, linux-kernel@vger.kernel.org
References: <11206164393426@foobar.com> <1120738525.4860.1433.camel@localhost> <E1DqVp3-00064l-00@chiark.greenend.org.uk>
In-Reply-To: <E1DqVp3-00064l-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507072054.51480.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 7 of July 2005 14:49, Matthew Garrett wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> > On Thu, 2005-07-07 at 22:04, Matthew Garrett wrote:
> >> Do you implement the entire swsusp userspace interface? If not, removing
> >> it probably isn't a reasonable plan without fair warning.
> > 
> > I'm not suggesting removing the sysfs interface or replacing system to
> > ram - just the suspend to disk part.
> 
> Right, so you support the resume from disk trigger in sysfs and the
> /proc/acpi/sleep interface? If suspend2 is a complete dropin replacement
> then I'm much happier with the idea of dropping swsusp, but I don't want
> to have to tie suspend/resume scripts to kernel versions.

I don't think that swsusp can be replaced with suspend2 right now.  First,
swsusp works on x86-64, and the support in suspend2 is preliminary,
AFAIK.  Second, the IA64 support for swsusp is in the works, and it is not supported
by suspend2.

Please don't plan to drop swsusp until you are able to replace it _completely_.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
