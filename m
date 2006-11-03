Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753247AbWKCOda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbWKCOda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 09:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbWKCOda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 09:33:30 -0500
Received: from vena.lwn.net ([206.168.112.25]:20879 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1753247AbWKCOda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 09:33:30 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dumb question for today 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 03 Nov 2006 10:48:18 +1100."
             <20061103104818.f280a003.sfr@canb.auug.org.au> 
Date: Fri, 03 Nov 2006 07:33:29 -0700
Message-ID: <2713.1162564409@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does vmalloc() zero the memory it allocates?

Nope, but vmalloc_user() will.

jon
