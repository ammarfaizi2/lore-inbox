Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVAOW0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVAOW0g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 17:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVAOW0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 17:26:35 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:45719 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262346AbVAOWZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 17:25:38 -0500
Date: Sat, 15 Jan 2005 23:25:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slab.c use of __get_user and sparse
Message-ID: <20050115222543.GB8989@mars.ravnborg.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20050115213906.GA22486@mars.ravnborg.org> <20050115220151.GA16442@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115220151.GA16442@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 11:01:51PM +0100, Andi Kleen wrote:
> > Based on the comment it is understood that suddenly this pointer points
> > to userspace, because the module got unloaded.
> > I wonder why we can rely on the same address now the module got unloaded -
> > we may risk this virtual address is taken over by someone else?
> 
> The address is not user space; you would be lying.
Which is very bad - dropped slab.c for now.

	Sam
