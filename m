Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbVFVKBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbVFVKBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVFVJ5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:57:23 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:11018 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262928AbVFVJyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:54:35 -0400
Subject: Re: [question] pass CONFIG_FOO to CC problem
From: Ian Campbell <ijc@hellion.org.uk>
To: coywolf@lovecn.org
Cc: lkml <linux-kernel@vger.kernel.org>, sam@ravnborg.org
In-Reply-To: <2cd57c90050622013937d2c209@mail.gmail.com>
References: <2cd57c90050622013937d2c209@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 10:54:30 +0100
Message-Id: <1119434071.16554.4.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-22 at 16:39 +0800, Coywolf Qi Hunt wrote:
> Hello,
> 
> I was expecting kbuild passes CONFIG_FOO from .config to CC
> -DCONFIG_FOO, but it doesn't.  So I have to add
> 
> ifdef CONFIG_FOO
> EXTRA_CFLAGS += -DCONFIG_FOO
> endif
> 
> Is that the right way? thanks in advance.

I think you need to #include <linux/config.h>

Ian.
-- 
Ian Campbell

BOFH excuse #186:

permission denied

