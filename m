Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVANWuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVANWuf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVANWtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:49:19 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:35341 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261416AbVANWr1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:47:27 -0500
Date: Fri, 14 Jan 2005 23:48:05 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 2/8 ] ltt for 2.6.10 : core headers
Message-ID: <20050114224805.GA15192@mars.ravnborg.org>
Mail-Followup-To: Karim Yaghmour <karim@opersys.com>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LTT-Dev <ltt-dev@shafik.org>
References: <41E76279.5020507@opersys.com> <20050114205507.GD8385@mars.ravnborg.org> <41E83F84.7080102@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E83F84.7080102@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Definitions used only internally by ltt shall stay in kernel/
> > 
> > This is generally agreed upon, but not yet common practice.
> 
> Should there be a kernel/ltt-core.h or should I just put all required
> definitions in kernel/ltt-core.c? The latter would result in a
> cluttered C file, I think. Though there aren't any .h's in kernel/,
> so I'm not sure what's the best way to proceed here.

The general approach here is to use a local .h files if there is
a considerable amount of definitions.
For a smaller set including them in the .c file is fine.

	Sam
