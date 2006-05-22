Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWEVPc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWEVPc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWEVPc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:32:59 -0400
Received: from xenotime.net ([66.160.160.81]:22477 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750700AbWEVPc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:32:59 -0400
Date: Mon, 22 May 2006 08:35:31 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 10/14/] Doc. sources: expose laptop-mode
Message-Id: <20060522083531.ad725cdf.rdunlap@xenotime.net>
In-Reply-To: <44714AC1.1060004@samwel.tk>
References: <20060521203349.40b40930.rdunlap@xenotime.net>
	<20060521205750.003b737c.rdunlap@xenotime.net>
	<44714AC1.1060004@samwel.tk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2006 07:23:13 +0200 Bart Samwel wrote:

> Randy.Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Documentation/laptop-mode.txt:
> > Expose example and tool source files in the Documentation/ directory in
> > their own files instead of being buried (almost hidden) in readme/txt files.
> > 
> > This will make them more visible/usable to users who may need
> > to use them, to developers who may need to test with them, and
> > to janitors who would update them if they were more visible.
> > 
> > Also, if any of these possibly should not be in the kernel tree at
> > all, it will be clearer that they are here and we can discuss if
> > they should be removed.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  Documentation/dslm.c          |  166 +++++++++++++++++++++++++++++++++++++++++
> >  Documentation/laptop-mode.txt |  170 ------------------------------------------
> 
> Arguably, dslm.c should be removed completely. It's something for which 
> everyone who knows how to compile a file named "dslm.c" can write a 
> usable replacement, using a couple of lines of shell scripting. If we 
> should include anything, it should be those lines of shell scripting, in 
> the docs, at most.

OK, sounds good to me.

> Point for discussion: should the laptop_mode script really still be in 
> laptop-mode.txt? AFAIK most distros use laptop-mode-tools or use their 
> own scripts to control this. Furthermore, the existing script is mostly 
> unmaintained, and it is full of bugs that were fixed long ago in 
> laptop-mode-tools (which was originally a fork of the script). I think 
> it would be better to replace it with a bit of documentation on which 
> things a laptop mode control script *should* tweak, *may want to* tweak, 
> etc., accompanied by an explanation why these tweaks are needed. I.e, an 
> "annotated spec", as one would expect to find in documentation. I'll 
> submit a patch to this effect when I find some time.

If it's really so unmaintained and mostly replaced, sounds like it should
be removed.  OTOH, if you want to keep several source files and/or
scripts, I would prefer to see a laptop-mode subdirectory for them.

---
~Randy
