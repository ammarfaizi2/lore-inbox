Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269239AbUISNH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269239AbUISNH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 09:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269240AbUISNH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 09:07:56 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:47633 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S269239AbUISNHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 09:07:55 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: Leandro Santi <lesanti@sinectis.com.ar>
Subject: Re: [PATCH 2.4] fix dcache nr_dentry race
Date: Sun, 19 Sep 2004 15:07:24 +0200
User-Agent: KMail/1.7
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
References: <20040919075057.GA2445@lesanti.hq.sinectis.com.ar>
In-Reply-To: <20040919075057.GA2445@lesanti.hq.sinectis.com.ar>
Organization: Linux-Systeme GmbH
X-Operating-System: Linux 2.4.20-wolk4.16 i686 GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409191507.24579@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 September 2004 09:50, Leandro Santi wrote:

Hi Leandro,

> The dentry_stat.nr_dentry counter isn't being properly protected against
> concurrent access. We've been observing a drift of about 8000 units per
> day on some large MP Maildir++ mailstore nodes.
> The following (trivial) patch is pretty much a backport from 2.6.

Almost the same fix was posted in August 2003.

http://marc.theaimsgroup.com/?l=linux-kernel&m=106203778320540&w=2


ciao, Marc
