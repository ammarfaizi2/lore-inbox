Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVG1RMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVG1RMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVG1RM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:12:27 -0400
Received: from graphe.net ([209.204.138.32]:32232 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261698AbVG1RLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:11:19 -0400
Date: Thu, 28 Jul 2005 10:11:18 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0507281006320.1262@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Andrew Morton wrote:

>   I remain fairly dubious about this - it seems a fairly specific and
>   complex piece of work to speed up one extremely specific part of one type of
>   computer's one type of workload.   Surely there's a better way :(

The patches provide the basis for more work on this issue. But we need to 
start somewhere. The specific issue addresses in the initial patchset is 
becoming a common case for multi-core applications.

>   The patches at present spit warnings or don't compile on lots of
>   architectures.  x86, x86_64, ppc64 and ia64 are OK.

I have just sent a fix to you this morning when I got your messages. 
Sadly I do not have access to the architectures that failed (arm, alpha 
and ppc32) but the fix simply removes code that is not used for these 
arches.
