Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUBSUUd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267547AbUBSUUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:20:33 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:40640 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S267543AbUBSUU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:20:29 -0500
Date: Thu, 19 Feb 2004 21:20:02 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andi Kleen <ak@suse.de>
Cc: Jakub Jelinek <jakub@redhat.com>, tony@atomide.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel x86-64 support patch breaks amd64
Message-ID: <20040219212002.GC382@zaniah>
References: <20040219183448.GB8960@atomide.com> <20040220171337.10cd1ae8.ak@suse.de> <20040219193606.GC31589@devserv.devel.redhat.com> <20040220174454.77ec7086.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220174454.77ec7086.ak@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004 at 17:44 +0000, Andi Kleen wrote:

> > > +#ifdef CONFIG_SMP_
> > 
> > 		    ^ Isn't this a typo?
> 
> Indeed. Thanks for catching it.
> 
> It probably doesn't hurt because I don't know of any module that uses cpu_sibling_map[].
> I think I just copied the export from i386. Maybe it would be best to just remove it completely.

Andrew added it a few hours ago, oprofile use it.

regards,
Phil
