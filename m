Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWDFCpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWDFCpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 22:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWDFCpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 22:45:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2945 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751345AbWDFCpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 22:45:04 -0400
Date: Wed, 5 Apr 2006 19:43:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org
Subject: Re: Respin: [PATCH] mm: limit lowmem_reserve
Message-Id: <20060405194344.1915b57a.akpm@osdl.org>
In-Reply-To: <200604061129.41658.kernel@kolivas.org>
References: <200604021401.13331.kernel@kolivas.org>
	<200604041235.59876.kernel@kolivas.org>
	<200604061110.35789.kernel@kolivas.org>
	<200604061129.41658.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> It is possible with a low enough lowmem_reserve ratio to make
>  zone_watermark_ok fail repeatedly if the lower_zone is small enough.

Is that actually a problem?
