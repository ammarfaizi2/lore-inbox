Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268527AbUIGTwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268527AbUIGTwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268525AbUIGTwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:52:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59662 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268634AbUIGTkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:40:40 -0400
Date: Tue, 7 Sep 2004 21:40:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.9-rc1-mm4: Makefile: remove tabs from empty lines
Message-ID: <20040907194009.GE2454@fs.tum.de>
References: <20040907020831.62390588.akpm@osdl.org> <20040907190212.GB2454@fs.tum.de> <20040907211422.GA6053@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907211422.GA6053@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 11:14:22PM +0200, Sam Ravnborg wrote:
> On Tue, Sep 07, 2004 at 09:02:12PM +0200, Adrian Bunk wrote:
> > On Tue, Sep 07, 2004 at 02:08:31AM -0700, Andrew Morton wrote:
> > >...
> > >  bk-kbuild.patch
> > >...
> > >  Latest versions of external trees
> > >...
> > 
> > 
> > Emacs warns me at every saving of the toplevel Makefile since it 
> > considers empty lines with a tab suspicious.
> Why do you need to edit top-level Makefile?

I'm setting CC and HOSTCC.
(I know I no longer have to edit Makefile for this so, but I'm used to 
 it...)

> Amyways I try to avoid these, but my gvim is pretty consistent in adding
> additional tabs/spaces here and there. Anyone that can tell me how to
> teach gvim not to do so (and flag trailing tabs/spaces).

Use Emacs.  ;-)
*duck'n'run*

> I have included below fix in patch that fixes '-j1' warning.

Thanks!

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

