Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWHRIav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWHRIav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWHRIak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:30:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:13528 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751217AbWHRIah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:30:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=cWy7LbupJ+IPVvK9Bq6NRyUWK6PAPoyarwWFi6QSab+3iPwgzevfDbSgSnz8Gf0OCPpOgk6++Hi9+rqEoSe+M4YOUXeH/PxNZac68Pgh8NamJt0JJoXNE5OY9ecMCXf3Mh0KjDxJsJbyGJpKUakzgvOHhcCF40f25uU2lyHLaY0=
Date: Fri, 18 Aug 2006 10:30:22 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "akpm@osdl.org" <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm1 + hotfix -- Many processes use the sysctl system call
Message-ID: <20060818103022.GA1586@slug>
References: <a44ae5cd0608171541tf2f125dl586f56da6f1b2a41@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0608171541tf2f125dl586f56da6f1b2a41@mail.gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 03:41:27PM -0700, Miles Lane wrote:
> My installation of Ubuntu is having trouble with my kernel build
> because I disabled support for sysctl:
> 
> warning: process `ls' used the removed sysctl system call
> warning: process `touch' used the removed sysctl system call
> warning: process `touch' used the removed sysctl system call
> warning: process `evms_activate' used the removed sysctl system call
> warning: process `alsactl' used the removed sysctl system call
> 
> I am curious whether the use of sysctl indicates a problem in these
> processes.  What is the benefit of offering disabling sysctl support?
> 
You may want to have a look at the '2.6.18-rc1-mm2: process `showconsole'
used the removed sysctl system call' thread in the archives.

Regards,
Frederik
> Thanks,
>        Miles
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
