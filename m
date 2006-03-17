Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbWCQNwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWCQNwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbWCQNwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:52:46 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:37560 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932698AbWCQNwp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:52:45 -0500
Message-ID: <441ABF40.4060805@de.ibm.com>
Date: Fri, 17 Mar 2006 14:53:04 +0100
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: carsteno@de.ibm.com
CC: Jes Sorensen <jes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
References: <yq0k6auuy5n.fsf@jaguar.mkp.net> <441ABEDD.4070003@de.ibm.com>
In-Reply-To: <441ABEDD.4070003@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otte wrote:
> If you use address as parameter to nopfn, it won't work with highmem
> on 32bit systems. Alternative would be to use (unsigned long) phys. page
> frame number.
Me stupid. I mean return value not address parameter.

Carsten
