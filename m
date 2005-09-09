Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbVIIU6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbVIIU6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbVIIU6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:58:25 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:61219 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030333AbVIIU6Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:58:24 -0400
Date: Fri, 9 Sep 2005 22:59:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: errs from build/makefiles
Message-ID: <20050909205946.GB19008@mars.ravnborg.org>
References: <20050909192113.GA8621@prophet.net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909192113.GA8621@prophet.net-ronin.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 12:21:13PM -0700, carbonated beverage wrote:
> I'm assuming some bash-isms crept into the tree, as I got these:
> 
>   LD      net/built-in.o
> /bin/sh: +@: not found
> make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.

Using the ':' buildin in several places is such a speedup for normal
usage that I do not plan to replace it with anything else.

	Sam
