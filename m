Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbWHOGqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbWHOGqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 02:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWHOGqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 02:46:16 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:32665 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965218AbWHOGqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 02:46:16 -0400
Date: Tue, 15 Aug 2006 08:44:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Howells <dhowells@redhat.com>
cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org#
Subject: Re: [RHEL5 PATCH 1/4] Provide fallback full 64-bit divide/modulus
 ops for gcc
In-Reply-To: <20060814211507.27190.61876.stgit@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.61.0608150837360.3819@yvahk01.tjqt.qr>
References: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
 <20060814211507.27190.61876.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> include/linux/kernel.h |    4 ++
> lib/Makefile           |    2 -
> lib/__udivdi3.c        |   23 +++++++++++
> lib/__udivmoddi4.c     |   99 ++++++++++++++++++++++++++++++++++++++++++++++++
> lib/__umoddi3.c        |   25 ++++++++++++

Umm, can we drop the __? Neither glibc nor gcc has underscores in the 
filenames of their udiv files.



Jan Engelhardt
-- 
