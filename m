Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTDONwW (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbTDONwW 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:52:22 -0400
Received: from hera.cwi.nl ([192.16.191.8]:36270 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261440AbTDONwW 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 09:52:22 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 15 Apr 2003 16:04:10 +0200 (MEST)
Message-Id: <UTC200304151404.h3FE4AY07391.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, zippel@linux-m68k.org
Subject: Re: [PATCH] kdevt-diff
Cc: Andries.Brouwer@cwi.nl, akpm@digeo.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW there are a few more functions missing, we need a dev_to_u32()
> and a dev_to_u16(), so e.g. file systems can do something useful
> in mknod if they can't store the complete number.

In such cases I cannot see any meaningful action other than returning
EOVERFLOW (or EINVAL in case you prefer that).

Andries


