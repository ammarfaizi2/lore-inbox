Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268383AbUIGTXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268383AbUIGTXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268449AbUIGTQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:16:32 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:30293 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268496AbUIGTOU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:14:20 -0400
Date: Tue, 7 Sep 2004 23:14:22 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.9-rc1-mm4: Makefile: remove tabs from empty lines
Message-ID: <20040907211422.GA6053@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
References: <20040907020831.62390588.akpm@osdl.org> <20040907190212.GB2454@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907190212.GB2454@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 09:02:12PM +0200, Adrian Bunk wrote:
> On Tue, Sep 07, 2004 at 02:08:31AM -0700, Andrew Morton wrote:
> >...
> >  bk-kbuild.patch
> >...
> >  Latest versions of external trees
> >...
> 
> 
> Emacs warns me at every saving of the toplevel Makefile since it 
> considers empty lines with a tab suspicious.
Why do you need to edit top-level Makefile?

Amyways I try to avoid these, but my gvim is pretty consistent in adding
additional tabs/spaces here and there. Anyone that can tell me how to
teach gvim not to do so (and flag trailing tabs/spaces).


I have included below fix in patch that fixes '-j1' warning.

	Sam
