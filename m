Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285073AbSA2W2d>; Tue, 29 Jan 2002 17:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbSA2W2Z>; Tue, 29 Jan 2002 17:28:25 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:24848 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S284902AbSA2W2H>;
	Tue, 29 Jan 2002 17:28:07 -0500
Date: Tue, 29 Jan 2002 12:38:09 +0100
From: Pavel Machek <pavel@suse.cz>
To: CaT <cat@zip.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Swsusp mailing list <swsusp@lister.fornax.hu>
Subject: Re: [swsusp] swsusp for 2.4.17 -- newer ide supported
Message-ID: <20020129113809.GE241@elf.ucw.cz>
In-Reply-To: <20020128100704.GA3013@elf.ucw.cz> <20020128231309.GD655@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020128231309.GD655@zip.com.au>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is newer version of swsusp patch. It now supports newer ide
> > driver (which just about everybody uses). It sometimes fails to
> > suspend when top is running, otherwise no bugs are known. Try to break
> > this one!
> 
> Having just (accidentally :) found out that my laptop does not survive 3
> days on suspend to ram I gotta ask... Will this version work with ext3?
> If so then I can try and break it. I just don't wanna use something that
> is known to be rude to filesystems. I like my data. :)

This version will refuse to suspend with ext3 in place; patch should
be somewhere in mailing lists of swsusp. I'll try to get it and merge.
								Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
