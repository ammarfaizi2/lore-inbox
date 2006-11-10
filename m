Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932853AbWKJMRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbWKJMRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932855AbWKJMRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:17:14 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:8137 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S932853AbWKJMRN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:17:13 -0500
From: Ed Tomlinson <edt@aei.ca>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1
Date: Fri, 10 Nov 2006 07:28:01 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061108015452.a2bb40d2.akpm@osdl.org> <200611092221.49238.edt@aei.ca> <20061109193153.a9709912.akpm@osdl.org>
In-Reply-To: <20061109193153.a9709912.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611100728.01237.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 November 2006 22:31, Andrew Morton wrote:
> On Thu, 9 Nov 2006 22:21:49 -0500
> Ed Tomlinson <edt@aei.ca> wrote:
> 
> > On Wednesday 08 November 2006 04:54, Andrew Morton wrote:
> > > -radeonfb-support-24bpp-32bpp-minus-alpha.patch
> > > 
> > >  Dropped
> > > 
> > > +various-fbdev-files-mark-structs-fix.patch
> > > 
> > >  Fix various-fbdev-files-mark-structs.patch
> > > 
> > > +fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch
> > > 
> > >  fbdev fix
> > 
> > Strongly suspect that something is not right with these patches.  I have a:
> > 
> > 01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01) (prog-if 00 [VGA])
....
> > gives a strangely corrupted screen.  The characters seem reversed...
> > 
> 
> Yup, thanks.  You'll need to revert
> fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch:'

Confirmed.  Reverting fixes the screen.

Thanks
Ed Tomlinson
