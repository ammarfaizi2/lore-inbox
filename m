Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVGWIwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVGWIwK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 04:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVGWIwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 04:52:09 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:15385 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261582AbVGWIwI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 04:52:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gvxCPl0/XhFKPaIioeDhwI+mqiWRSylxx18o30VrWsXHKTPlgqEcwgmGyEPjVUB6e8PFhQnh9MEbUhvo/qoPgDeymiMQrBpdeYeCbI8CeGAovSOtO4iDmyMSJhZRmKDD6FuRfDc0g5u33KHjm0ujtQ8XSnEuFKRzsiDWl87/WiU=
Message-ID: <2cd57c9005072301522c8d6ec9@mail.gmail.com>
Date: Sat, 23 Jul 2005 16:52:07 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] turn many #if $undefined_string into #ifdef $undefined_string
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <200507230413_MC3-1-A559-7852@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507230413_MC3-1-A559-7852@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/05, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> On Fri, 22 Jul 2005 at 16:48:05 +0200, Olaf Hering wrote:
> 
> > turn many #if $undefined_string into #ifdef $undefined_string
> > to fix some warnings after -Wno-def was added to global CFLAGS
> 
> 
>  Shouldn't that be "#if defined($undefined_string)"?
> 
>  #ifdef is obsolete...
> 

What leads you to believe that?

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
