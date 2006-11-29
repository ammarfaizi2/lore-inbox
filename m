Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756344AbWK2L2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbWK2L2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 06:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757664AbWK2L2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 06:28:44 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:15185 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1756498AbWK2L2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 06:28:43 -0500
Message-ID: <456D6EE4.1070404@tls.msk.ru>
Date: Wed, 29 Nov 2006 14:28:36 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060813)
MIME-Version: 1.0
To: Torben Mathiasen <torben.mathiasen@hp.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devices.txt - LANANA merge
References: <20061129102159.GC11879@linux>
In-Reply-To: <20061129102159.GC11879@linux>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torben Mathiasen wrote:
> Here's a merge with the latest from LANANA. Its been a while, so _please_ let
> me know if anyone sees unwanted changes. A few whitespaces and formatting
> changes included too.
[]
> +258 block	ROM/Flash read-only translation layer
> +		  0 = /dev/blockrom0	First ROM card's translation layer interface
> +		  1 = /dev/blockrom0	Second ROM card's translation layer interface
                                  ^^^

Shouldn't here be '1', ie, /dev/blockrom1 ?

/mjt
