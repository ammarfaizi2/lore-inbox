Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVEYV6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVEYV6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 17:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVEYV6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 17:58:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10651 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261303AbVEYV6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 17:58:48 -0400
Date: Wed, 25 May 2005 23:58:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Reiner Sailer <sailer@us.ibm.com>
Cc: Emilyr@us.ibm.com, James Morris <jmorris@redhat.com>, Kylene@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       Toml@us.ibm.com, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and Readme
Message-ID: <20050525215827.GB4590@elf.ucw.cz>
References: <Pine.WNT.4.63.0505251116180.3308@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0505251116180.3308@laptop>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 
> > > If I understand you, then you are claiming that steps (ii) to (v) 
> > > introduce buffer overflows in bash or show_etc_issue. How?
> > 
> > No, I'm not claiming that. You are certainly *not* introducing any new
> > problems.
> > 
> > But some problems that used to be harmless (buffer overrun in
> > show_etc_issue command) are not harmless any more.
> 
> How is a buffer overrun in a script/application less "harmless" with IMA? 
> Please be specific. Preliminary IMA patches are out on the mailing lists.
> 
> The only thing that IMA does with respect to existing known buffer 
> overruns is that it enables remote parties to know that there is an application 
> with a known buffer overrun if this application/script was measured. Such 
> information is sensitive and this is one reason why direct access to the 
> measurements are restricted to authorized/trusted parties.

Well, you'll have to add measurement of any security-sensitive config
file, any script, and will have to make sure that all parsing of
system config files does not contain buffer-overrun problems. That's
lot of work before IMA is usefull. It is true you do not make
situation any worse.

Good luck and go ahead.
								Pavel
