Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270783AbUJUSVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270783AbUJUSVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUJUSQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:16:48 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:22558 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S270692AbUJUSOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:14:40 -0400
Date: Thu, 21 Oct 2004 22:15:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module compilation
Message-ID: <20041021201545.GA16474@mars.ravnborg.org>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0410201034590.12062@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410201034590.12062@chaos.analogic.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 10:36:00AM -0400, Richard B. Johnson wrote> 
> ...but it's not CFLAGS that needs to be modified, it's
> a named variable that doesn't exist yet, perhaps "USERDEF",
> or "DEFINES".

Reading the above I cannot what amkes you say that EXTRA_CFLAGS
or CFLAGS_module.o cannot be used?
Is it the name you do not like or is it some fnctionality
you are missing?

>I see that the normal "defines" is a constant 
> called "CHECKFLAGS", so this isn't appropriate for user
> modification.
CHECKFLAGS is only used when you use "make C=1" - to pass options
to sparse.

	Sam
