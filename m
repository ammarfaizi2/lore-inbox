Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWHABFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWHABFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 21:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWHABFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 21:05:39 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:14775 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751552AbWHABFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 21:05:39 -0400
Date: Mon, 31 Jul 2006 18:06:52 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de
Subject: Re: [PATCH] x86_64 built-in command line
Message-ID: <20060801010652.GA17771@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20060731171442.GI6908@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731171442.GI6908@waste.org>
Organization: Plexity Networks
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 31 2006, at 12:14, Matt Mackall was caught saying:
> Allow setting a command line at build time on x86_64. Compiled but not
> tested.

Can we just make this into a generic option and put the relevant strcpy
(strcat) in init/main.c. We've supported a default in-kernel command line
on ARM for sometime now and I think it would be best to just have a single
implementation.

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

"An open heart has no possessions, only experiences" - Matt Bibbeau
