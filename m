Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265931AbUEURI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUEURI5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 13:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUEURI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 13:08:57 -0400
Received: from gprs214-11.eurotel.cz ([160.218.214.11]:17793 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265931AbUEURIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 13:08:55 -0400
Date: Fri, 21 May 2004 19:08:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
Message-ID: <20040521170847.GA14739@elf.ucw.cz>
References: <40A8606D.1000700@linuxmail.org> <20040521093307.GB15874@elf.ucw.cz> <40ADF605.2040809@linuxmail.org> <200405211542.40587.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200405211542.40587.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Kernel threads are different, and each must be handled separately,
> > > maybe even with some ordering. But there's relatively small number of
> > > kernel threads... 
> > 
> > Yes, but what order? I played with that problem for ages. Perhaps I just 
> >   didn't find the right combination.
> 
> How about recording the order of creation and do it in opposite order?

Order of creation is pretty much hidden in pid, but I do not think
that will work.
								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
