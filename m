Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVF2SLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVF2SLF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVF2SLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:11:04 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:43712 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262363AbVF2SI5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:08:57 -0400
Date: Wed, 29 Jun 2005 11:08:51 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: ismail@kde.org.tr, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc1 problems
Message-Id: <20050629110851.1766a4e0.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0506291842360.4262@goblin.wat.veritas.com>
References: <200506291934.32909.ismail@kde.org.tr>
	<Pine.LNX.4.61.0506291805090.3940@goblin.wat.veritas.com>
	<200506292015.11494.ismail@kde.org.tr>
	<Pine.LNX.4.61.0506291842360.4262@goblin.wat.veritas.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005 18:51:07 +0100 (BST) Hugh Dickins wrote:

| On Wed, 29 Jun 2005, Ismail Donmez wrote:
| > 
| > Thank you both!. Any idea about this part? :
| > 
| > Jun 29 19:16:32 localhost kernel: Badness in __kfree_skb at 
| > net/core/skbuff.c:290
| 
| I've not seen that one.  It's _possible_ that it's caused by the
| same get_request bug: although that's over in a different subsystem,
| it does mess up the preempt_count/hardirq_count enough to be able to
| cause such a problem elsewhere.  But I see this message came 87 secs
| after your others, which makes that unlikely.  Do you still see this
| __kfree_skb badness after running with the get_request fix?

crap, sorry about misidentifying that.

---
~Randy
