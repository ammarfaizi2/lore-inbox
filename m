Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWF0RRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWF0RRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWF0RRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:17:24 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:19078 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932131AbWF0RRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:17:23 -0400
Subject: Re: [PATCH 1/7] bootmem: remove useless __init in header file
From: Dave Hansen <haveblue@us.ibm.com>
To: Franck <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44A12A43.3050501@innova-card.com>
References: <449FDD02.2090307@innova-card.com>
	 <1151344691.10877.44.camel@localhost.localdomain>
	 <44A12A43.3050501@innova-card.com>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 10:17:00 -0700
Message-Id: <1151428620.24103.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 14:53 +0200, Franck Bui-Huu wrote:
> +extern void * __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
> +extern void * __alloc_bootmem_nopanic (unsigned long size, unsigned long align, unsigned long goal); 

Since we're being picky about kernel coding style, doesn't the '*' go
next to the function name? ;)

-- Dave

