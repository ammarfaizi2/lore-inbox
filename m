Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWD0Sqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWD0Sqs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWD0Sqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:46:48 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:30189 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S964951AbWD0Sqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:46:48 -0400
Message-ID: <4451117A.7040003@colorfullife.com>
Date: Thu, 27 Apr 2006 20:46:18 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20060212 Fedora/1.7.12-5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: redzone double-free detection
References: <1146160076.11272.5.camel@localhost>
In-Reply-To: <1146160076.11272.5.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

>From: Pekka Enberg <penberg@cs.helsinki.fi>
>
>This patch adds double-free detection to redzone verification when freeing
>an object. As explained by Manfred, when we are freeing an object, both
>redzones should be RED_ACTIVE. However, if both are RED_INACTIVE, we are
>trying to free an object that was already free'd.
>
>Cc: Manfred Spraul <manfred@colorfullife.com>
>Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
>  
>
Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

