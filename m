Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVFZCzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVFZCzy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 22:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVFZCzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 22:55:53 -0400
Received: from graphe.net ([209.204.138.32]:15013 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261427AbVFZCzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 22:55:52 -0400
Date: Sat, 25 Jun 2005 19:55:50 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, raybry@engr.sgi.com,
       torvalds@osdl.org
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable
 for other purposes
In-Reply-To: <20050626023053.GA2871@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.62.0506251954470.26198@graphe.net>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
 <20050625025122.GC22393@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506242311220.7971@graphe.net>
 <20050626023053.GA2871@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2005, Pavel Machek wrote:

> > 4. Remove the argument that is no longer necessary from two function
> > calls.
> 
> Can you just keep the argument? Rename it to int unused or whatever,
> but if you do it, it stays backwards-compatible (and smaller patch,
> too).

Why do you want to specify a parameter that is never used? It was quite confusing to me 
and I would think that such a parameter will also be confusing to others.
