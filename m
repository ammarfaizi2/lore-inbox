Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVIGU37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVIGU37 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVIGU37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:29:59 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:55742 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932243AbVIGU36 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:29:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LbzZyGblzsinGpDwUou+CPQgCAmmwkNpJfiAvcomnKou/xJHc6taxfy1+ukJtYHnrvd+XArC+gvuNE7mhym06mNIOkm9s3PoDeMK/K/al6PQsf9AslaBD85vkuIzauq0Cf9NX4KqpfhIhpieqFY7JvILIBznSWVgMJPcuDRdk+I=
Message-ID: <58d0dbf1050907132951a2aee7@mail.gmail.com>
Date: Wed, 7 Sep 2005 22:29:55 +0200
From: Jan Kiszka <jan.kiszka@googlemail.com>
Reply-To: jan.kiszka@googlemail.com
To: Daniel Phillips <phillips@istop.com>
Subject: Re: RFC: i386: kill !4KSTACKS
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200509071617.24181.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	 <58d0dbf10509071054175e82ff@mail.gmail.com>
	 <200509071552.27543.phillips@istop.com>
	 <200509071617.24181.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/9/7, Daniel Phillips <phillips@istop.com>:
> On Wednesday 07 September 2005 15:52, Daniel Phillips wrote:
> Ah, there's another issue: an interrupt can come in when esp is on the ndis
> stack and above THREAD_SIZE, so do_IRQ will not find thread_info.  Sorry,
> this one is nasty.
> 

Oh, you already got it as well.

Jan
