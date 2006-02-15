Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945942AbWBONvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945942AbWBONvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945944AbWBONvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:51:12 -0500
Received: from sigma957.CIS.mcmaster.ca ([130.113.64.83]:45220 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S1945942AbWBONvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:51:11 -0500
Date: Wed, 15 Feb 2006 08:50:50 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Coywolf Qi Hunt <qiyong@fc-cn.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] make sysctl_overcommit_memory enumeration sensible
In-Reply-To: <43F2EDD6.7000204@yahoo.com.au>
Message-ID: <Pine.LNX.4.44.0602150846170.4737-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2006.02.15.052607
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's the point? The current has been there for a long time, and
> is well documented.

right - low-pointage user-space break.  it _would_ make a small amount of
sense to use a string (never/guess/always works for me), but the existing
meanings (2/0/1 respectively) would need to be provided through a major 
release cycle then generate an error if used...

regards, mark hahn.

