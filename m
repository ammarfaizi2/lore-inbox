Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbTDVX0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 19:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263907AbTDVX0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 19:26:09 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:25025 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263904AbTDVX0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 19:26:08 -0400
Date: Tue, 22 Apr 2003 19:34:56 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH][ANNOUNCE] Linux 2.5.68-ce2
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304221938_MC3-1-358E-F55B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jvrn Engel wrote:


> +#include <linux/cache.h>
> +#define CACHELINE_ALIGN .align L1_CACHE_BYTES,0x90
> ...
> -	ALIGN
> +	CACHELINE_ALIGN



 I just found this in include/linux/linkage.h:


#define CACHE_ALIGN     ALIGN



:(



------
 Chuck
