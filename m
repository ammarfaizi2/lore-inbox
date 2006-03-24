Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWCXSdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWCXSdu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWCXSdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:33:50 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:44434 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751144AbWCXSdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:33:49 -0500
Date: Fri, 24 Mar 2006 19:30:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let x86 subarchs select SMP
In-Reply-To: <20060324165613.GF22727@stusta.de>
Message-ID: <Pine.LNX.4.64.0603241928480.17704@scrub.home>
References: <20060324165613.GF22727@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 24 Mar 2006, Adrian Bunk wrote:

> The SMP question comes after the subarch question, and it does therefore 
> make sense to let the SMP-only subarchs select SMP instead of depending 
> on it.

No, it doesn't make sense. If the ordering is wrong, fix the ordering, but 
that's a silly reason to use select.

bye, Roman
