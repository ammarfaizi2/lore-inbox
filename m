Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbUBRLOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbUBRLOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:14:05 -0500
Received: from karnickel.franken.de ([193.141.110.11]:54798 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S264457AbUBRLNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:13:36 -0500
Date: Wed, 18 Feb 2004 12:09:33 +0100
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3
Message-ID: <20040218110933.GD5320@debian.franken.de>
References: <Pine.LNX.4.58.0402172013320.2686@home.osdl.org> <20040218101702.GA5551@debian.franken.de> <20040218110232.GU1308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218110232.GU1308@fs.tum.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: erik@debian.franken.de (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 12:02:32PM +0100, Adrian Bunk wrote:
> On Wed, Feb 18, 2004 at 11:17:02AM +0100, Erik Tews wrote:
> > On Tue, Feb 17, 2004 at 08:15:08PM -0800, Linus Torvalds wrote:
> > > 
> > > Ok, it's out.
> > > 
> > > There were some minimal changes relative to the last -rc4, mostly some 
> > > configuration and build fixes, but a few important one-liners too.
> > 
> > Ext3 doesn't seem to compile without jbd support.
> 
> This is correct.
> 
> How did you manage to get a configuration with ext3 but without JBD?

I did not, and I did not try to do so.

There is only one menu-item to select for jbd, so there are only 2
possible configurations. Without jbd it doesn't compile, with jbd, it
compiles.

If you are going to make it work without jbd, you have to touch the
source.
