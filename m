Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWHIIMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWHIIMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWHIIMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:12:14 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:57231 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965099AbWHIIMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:12:12 -0400
Message-ID: <44D99901.20202@sw.ru>
Date: Wed, 09 Aug 2006 12:12:49 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Muli Ben-Yehuda <muli@il.ibm.com>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, dev@openvz.org, stable@kernel.org
Subject: Re: + sys_getppid-oopses-on-debug-kernel.patch added to -mm tree
References: <200608081432.k78EWprf007511@shell0.pdx.osdl.net> <20060808143937.GA3953@rhun.haifa.ibm.com> <20060808145138.GA2720@atjola.homenet> <20060808145709.GB3953@rhun.haifa.ibm.com> <1155050547.5729.91.camel@localhost.localdomain> <44D8B048.8060103@sw.ru> <20060808163635.GF28990@redhat.com>
In-Reply-To: <20060808163635.GF28990@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > >>Even without getting into just how ugly this is, is it really worth
>  > >>it?
>  > it is impossible to run debug kernels w/o this patch :/
>  > or are you asking whether this optimization worth it?
>  > 
>  > What makes me worry is that this is a sign that vendors
>  > don't even bother to run debug kernels :((((
> 
> Fedora rawhide is nearly always shipping with DEBUG_SLAB enabled,
> and we didn't hit this once.  Are you sure this is a problem
> with DEBUG_SLAB, and not DEBUG_PAGEALLOC ?
Sorry, it's my fault. Surely, CONFIG_DEBUG_PAGEALLOC.

Kirill

