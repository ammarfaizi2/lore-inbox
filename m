Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSJRQNV>; Fri, 18 Oct 2002 12:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265248AbSJRQNV>; Fri, 18 Oct 2002 12:13:21 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:9199 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265247AbSJRQNU>; Fri, 18 Oct 2002 12:13:20 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <29929.1034955828@ocs3.intra.ocs.com.au> 
References: <29929.1034955828@ocs3.intra.ocs.com.au> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Christoph Hellwig <hch@sgi.com>, John Hesterberg <jh@sgi.com>,
       linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 18 Oct 2002 17:19:10 +0100
Message-ID: <23005.1034957950@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  There is even source code that needs to know if CONFIG_FOO was set to
> y or m, that code needs the existing separation between CONFIG_FOO and
> CONFIG_FOO_MODULE. 

No. That code needs to be fixed so it doesn't ever look at 
CONFIG_FOO_MODULE.

--
dwmw2


