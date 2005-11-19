Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbVKSBfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbVKSBfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbVKSBfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:35:37 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:25996
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1161110AbVKSBfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:35:36 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 18 Nov 2005 19:33:27 -0600
User-Agent: KMail/1.8
Cc: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>, linux-kernel@vger.kernel.org
References: <1132020468.27215.25.camel@mindpipe> <dld3cs$1sh$1@sea.gmane.org> <20051115185543.GI5735@stusta.de>
In-Reply-To: <20051115185543.GI5735@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511181933.27320.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2005 12:55, Adrian Bunk wrote:
> I experienced something similar with my patch to schedule OSS drivers
> with ALSA replacements for removal - when someone reported he needed an
> OSS driver for $reason I asked him for bug numbers in the ALSA bug
> tracking system - and the highest number were 4 new bugs against one
> ALSA driver.

Speaking of which: I've been playing with qemu recently, and the sound card it 
emulates is a sound blaster 16.  Which only seems to have an OSS driver, no 
ALSA...

This is known?  If so I might take a whack at porting this if I get really 
bored this weekend...

Rob
