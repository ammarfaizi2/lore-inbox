Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265291AbUFTOTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUFTOTd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 10:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUFTOTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 10:19:33 -0400
Received: from [213.146.154.40] ([213.146.154.40]:43993 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265291AbUFTOTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 10:19:25 -0400
Subject: Re: [PATCH] Stop printk printing non-printable chars
From: David Woodhouse <dwmw2@infradead.org>
To: matthew-lkml@newtoncomputing.co.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040619154907.GE5286@newtoncomputing.co.uk>
References: <20040618205355.GA5286@newtoncomputing.co.uk>
	 <1087643904.5494.7.camel@imladris.demon.co.uk>
	 <20040619154907.GE5286@newtoncomputing.co.uk>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Jun 2004 15:17:44 +0100
Message-Id: <1087741064.28195.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-3.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-19 at 16:49 +0100, matthew-lkml@newtoncomputing.co.uk
wrote:
> Please forgive me if I'm wrong on this, but I seem to remember reading
> something a while ago indicating that the kernel is and always will be
> internally English (i.e. debugging messages and the like) as there is no
> need to bloat it with many different languages (that can be done in
> userspace). As printk is really just a log system, I personally don't
> see any way that it should ever print anything other than ASCII.

It's very naïve of you to think that English means nothing but ASCII.
Non-ASCII characters play a very important rôle even in English
communication.

-- 
dwmw2

