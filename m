Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbUKVQmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbUKVQmY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbUKVQl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:41:58 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:16443 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262175AbUKVQSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:18:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=R35Zd5kUH/4QdyYLKWjp2EMf4QEoJ+VQKCqXpFHtvVtKrn1Fqd7ZYrwmDPO2a1bJhbviqOKb5Zi640nss6k5lRgJCGeYAcDv6yYn/PLFYpqeQerGDlmTH0KcpLAZ4GoGEDXs56ZqZJhnQ9XFjIMfbjZ2iAHE1LXVPa9fh3SOufA=
Message-ID: <876ef97a04112208184bbc1385@mail.gmail.com>
Date: Mon, 22 Nov 2004 11:18:48 -0500
From: Tobias DiPasquale <codeslinger@gmail.com>
Reply-To: Tobias DiPasquale <codeslinger@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] add list_del_head function
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
In-Reply-To: <20041122092059.GA16487@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <876ef97a04112007562d6797e@mail.gmail.com>
	 <20041122092059.GA16487@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004 10:20:59 +0100, Jens Axboe <axboe@suse.de> wrote: 
> Generally patches like this have little merrit unless accompanied by
> another patch converting several obvious pieces of kernel code to use
> it.
> 
> Also I find the interface awkward and different from the other list
> functions.
> 
>         entry = list_del_head(list);
> 
> would have been much nicer.

Ok I'll do both things and resubmit. Thanks for getting back to me :)

-- 
[ Tobias DiPasquale ]
0x636f6465736c696e67657240676d61696c2e636f6d
