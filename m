Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVDYRi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVDYRi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVDYRiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:38:09 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:30163 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262699AbVDYRhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:37:40 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
To: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Reply-To: 7eggert@gmx.de
Date: Mon, 25 Apr 2005 19:36:36 +0200
References: <3X9X6-5JP-27@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DQ7Vg-0003fq-DC@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias-Christian Ott <matthias.christian@tiscali.de> wrote:

> The "git" didn't try store small variables, which aren't referenced, in
> the processor registers. It also didn't use the size_t type. I corrected
> a C++ style comment too.

I have compared functions using 'register' against functions not doing that.
Not using register allowed better optimization on my x86.
-- 
The most dangerous thing in the world is a second lieutenant with a map and
a compass.

