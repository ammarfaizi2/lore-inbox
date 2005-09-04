Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVIDLga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVIDLga (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 07:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVIDLga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 07:36:30 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:31705 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750748AbVIDLga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 07:36:30 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] lib/sort.c: small cleanups
Date: Sun, 4 Sep 2005 13:35:37 +0200
User-Agent: KMail/1.7.2
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
References: <20050903132531.GO3657@stusta.de>
In-Reply-To: <20050903132531.GO3657@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041335.38532.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 September 2005 15:25, Adrian Bunk wrote:
> This patch contains the following small cleanups:
> - make two needlessly global functions static
> - every file should #include the header files containing the prototypes 
>   of it's global functions

While this is a nice cleanup, does anybody remember,
why the inner loops are duplicated in the source?

If there are no arguments for it, I would like to consolidate them
to a function or a define, if they share to much state.

Or is the duplicate just considered cleaner?


Regards

Ingo Oeser

