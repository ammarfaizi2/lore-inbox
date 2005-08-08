Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVHHPta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVHHPta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVHHPta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:49:30 -0400
Received: from graphe.net ([209.204.138.32]:50669 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932091AbVHHPt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:49:29 -0400
Date: Mon, 8 Aug 2005 08:49:27 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Task notifier against mm: Implement todo list in
 task_struct
In-Reply-To: <20050808094301.GA1784@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0508080848290.19159@graphe.net>
References: <Pine.LNX.4.62.0507291328170.5304@graphe.net>
 <Pine.LNX.4.62.0507291332100.5304@graphe.net> <20050730112241.GA1830@elf.ucw.cz>
 <Pine.LNX.4.62.0507300843100.24809@graphe.net> <20050730161007.GA1885@elf.ucw.cz>
 <Pine.LNX.4.62.0507300916170.25259@graphe.net> <20050730162223.GB1885@elf.ucw.cz>
 <Pine.LNX.4.62.0508011141440.5458@graphe.net> <20050808094301.GA1784@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Pavel Machek wrote:

> Hi!
> 
> > Got a new suspend patchsset at 
> > 
> > ftp://ftp.kernel.org:/pub/linux/kernel/people/christoph/suspend/2.6.13-rc4-mm1
> > 
> > Check the series file for the sequence of patches.
> 
> Something still goes very wrong after first resume. It seems to work
> ok for few seconds, then console switch takes 10 seconds to react and
> cursor stops blinking, and then it is dead.

Could you get me some more details as to what is happening?

This means it:

1. suspends correctly.

2. resumes.

3. Then after 10 seconds there is a crash?

