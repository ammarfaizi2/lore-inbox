Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269505AbUICDhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269505AbUICDhR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUIBUZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:25:44 -0400
Received: from mail.enyo.de ([212.9.189.167]:55314 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S268986AbUIBUWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:22:47 -0400
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Identify security-related patches
References: <4136C6E1.4090404@bio.ifi.lmu.de>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Thu, 02 Sep 2004 22:22:43 +0200
In-Reply-To: <4136C6E1.4090404@bio.ifi.lmu.de> (Frank Steiner's message of
	"Thu, 02 Sep 2004 09:08:17 +0200")
Message-ID: <87y8jsto8c.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Frank Steiner:

> is there an easy way to identify all security-related patches out of the
> mass of patches floating around  on linux.bkbits.net or the kernel bugzilla?
>
> I'm running 2.6.8.1 and would like to keep it as stable as possible, thus,
> only apply security patches. Currently I'm searching for "security" and
> alike on bitkeeper, but there seems to be no consistent marking.

No, there isn't.  You won't see any official kernel.org advisories
that could serve as guide, either.

However, your concentration might be a bit short-sighted.  Issues such
as stability (random crashes under load), data corruption (file
systems are corrupted on unmount) and performance (poor throughtput
with some USB devices) could be as important to your users as security
fixes.  In this area, vendor kernels can serve as a guide, too.

Unfortunately, there is no distributed source code management system
used by all these forks, so relating all those changes appears to be
quite complicated.
