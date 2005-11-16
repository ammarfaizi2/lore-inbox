Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbVKPWkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbVKPWkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbVKPWkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:40:22 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:36524 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030541AbVKPWkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:40:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ncunningham@cyclades.com
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Wed, 16 Nov 2005 23:41:03 +0100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
       "Gross, Mark" <mark.gross@intel.com>, Dave Jones <DaveJ@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116220500.GF12505@elf.ucw.cz> <1132175574.25230.111.camel@localhost>
In-Reply-To: <1132175574.25230.111.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511162341.04652.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 16 of November 2005 22:13, Nigel Cunningham wrote:
> On Thu, 2005-11-17 at 09:05, Pavel Machek wrote:
}-- snip --{
> > So... to get 225 patches in, you'll need to explain that
> > userland-swsusp can't work. If you can do that, please be nice and do
> > it soon, so that I don't waste too much time on userland-swsusp.
> 
> I thought Dave already did that.

Not as far as I'm concerned.  He criticised the implementation,
which I generally agree with, but IMO the overall idea is not wrong.

BTW, you don't need to export the page flags, use /dev/kmem etc. to implement
it.  The only concern that I have wrt it is the writing of the image _after_ the
system has been snapshotted.

Greetings,
Rafael
