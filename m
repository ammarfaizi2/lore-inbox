Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbVKPNVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbVKPNVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVKPNVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:21:47 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:44754
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030320AbVKPNVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:21:47 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 10/15] misc: Make *[ug]id16 support optional
Date: Wed, 16 Nov 2005 07:21:30 -0600
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <11.282480653@selenic.com>
In-Reply-To: <11.282480653@selenic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160721.30845.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 November 2005 02:35, Matt Mackall wrote:
> Configurable 16-bit UID and friends support
>
> This allows turning off the legacy 16 bit UID interfaces on embedded
> platforms.

Is there an easy way to make sure our programs aren't using these?  (If I 
build a new system from source with busybox and uclibc, how do I know if I 
can disable this?)

The help text is highly unrevealing...

Rob
